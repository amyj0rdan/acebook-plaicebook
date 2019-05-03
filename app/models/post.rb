class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  def less_than_ten_mins_ago
    (Time.now - created_at) / 60 <= 10
  end
end
