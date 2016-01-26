class Venture < ActiveRecord::Base

  has_many :users
  has_many :notifications
  has_many :messages

  validates_presence_of :name, :v_image, :explain, :reason, :vision, :job_offer, :owner

  has_attached_file :v_image,
                    :styles => {
                      :thumb  => "150x100",
                      :medium => "300x200",
                      :large  => "600x400"
                    },
                    :storage        => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path           => ":attachment/:id/:style.:extension"
  validates_attachment_content_type :v_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def authenticated_vimage_url(style)
    v_image.s3_object(style).url_for(:read, :secure => true)
  end

end
