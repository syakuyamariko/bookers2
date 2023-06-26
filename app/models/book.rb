class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

#バリデーションの設定
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 200 } #200文字まで
end
