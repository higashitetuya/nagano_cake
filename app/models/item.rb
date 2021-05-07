class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :image, presence: { message: 'を選択してください' }
  validates :name, presence: { message: 'を入力してください' }
  validates :introduction, presence: true
  validates :price, presence: true
  #validates :genre, presence: { message: 'を選択してください' }

  def self.search(search) #self.はItem.を意味する
     if search
       where(['name LIKE ? OR price LIKE ?', "%#{search}%","%#{search}%"]) #検索とnameの部分一致を表示。
     else
       all
     end
  end
end
