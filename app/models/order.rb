class Order < ApplicationRecord
  enum payment_method: [:クレジットカード, :銀行振込]
  enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送待ち: 3, 発送済: 4}

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
end
