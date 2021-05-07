class Address < ApplicationRecord
  belongs_to :customer

  def view
  '〒' + self.postal_code + ' ' + self.address + ' ' + self.name
  end

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
