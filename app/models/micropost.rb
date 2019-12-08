class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :comment, presence: true, length: { maximum: 255 }
  validates :spot, presence: true, length: { maximum: 30 }
  
  has_many :favorites
  has_many :favorite_user, through: :favorites, source: :user
  
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Micropost.where(['spot LIKE ?', "%#{search}%"])
    else
      Micropost.all #全て表示。
    end
  end
  
end
