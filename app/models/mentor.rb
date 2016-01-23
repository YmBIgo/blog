class Mentor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # association
  has_many :notifications

  ## 新規追加前は、validation を増やして
  ## 　　環境変数に追加！　　
  validates :email, :inclusion => { :in => ["IgYmB0218LP@gmail.com"] }

  ## s3 image
  has_attached_file :m_image,
                    :styles => {
                      :thumb  => "100x100",
                      :medium => "150x150",
                      :large  => "400x400"
                    },
                    :storage        => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path           => ":attachment/:id/:style.:extension"
  validates_attachment_content_type :m_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def authenticated_mimage_url(style)
    m_image.s3_object(style).url_for(:read, :secure => true)
  end

  def name
    if family_name.present? && first_name.present?
      "#{family_name} #{first_name}様"
    else
      "ゲスト様"
    end
  end
end
