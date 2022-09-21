class Genre < ApplicationRecord
  has_one_attached :genre_image
  has_many :events

  def get_genre_image(width, height)
    unless genre_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      genre_image.attach(io: File.open(file_path), filename: "no_image.jpeg", content_type: "image/jpeg")
    end
    genre_image.variant(resize_to_limit: [width, height]).processed
  end
end
