class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :venture
  has_many   :notifications

  ## s3 image
  has_attached_file :image,
                    :styles => {
                      :thumb  => "100x100",
                      :medium => "150x150",
                      :large  => "400x400"
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
    family_name? && first_name? && age? && belong? && image?
  end

  def register_venture?
    Venture.where('owner = ?', id).present?
  end

  def owned_venture
    if register_venture?
      Venture.where('owner = ?', id).first
    else
    end
  end

  def name
    if family_name.present? && first_name.present?
      "#{family_name} #{first_name}様"
    else
      "ゲスト様"
    end
  end

end
