class User < ApplicationRecord
  validates :name, presence: true, length: { maximum:10 }
  has_secure_password
  
  has_many :microposts
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  def favorite(micropost)
      self.favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavorite(micropost)
      favorite = self.favorites.find_by(micropost_id: micropost.id)
      favorite.destroy if favorite
  end
  
  def favorite?(micropost)
      self.favorite_microposts.include?(micropost)
  end
end
