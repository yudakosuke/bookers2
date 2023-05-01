class User < ApplicationRecord
 devise :database_authenticatable, :registerable,
 :recoverable, :rememberable, :validatable
 has_many :books, dependent: :destroy
 validates :name, uniqueness: true
 validates :name, presence: true, length: { minimum: 2, maximum: 20 }
 validates :introduction, length: { maximum: 50 }
   has_one_attached :profile_image

 def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
 end
end