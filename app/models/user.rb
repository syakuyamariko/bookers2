class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy #Userモデルに Bookモデルを関連付ける

  has_one_attached :profile_image

  #バリデーションの設定

  validates :name, uniqueness: true #名前の一意性
  validates :name, length: { minimum: 2, maximum: 20 } #名前文字数制限
  validates :introduction, length: { maximum: 50 }
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
