class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## s3 image
  has_attached_file :image,
                    :styles => {
                      :thumb  => "100x100",
                      :medium => "200x200",
                      :large  => "600x400"
                    },
                    :storage        => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path           => ":attachment/:id/:style.:extension"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def authenticated_image_url(style)
    image.s3_object(style).url_for(:read, :secure => true)
  end

  def full_profile?
    family_name? && first_name? && age? && belong? && self_intro? && image?
  end

end
