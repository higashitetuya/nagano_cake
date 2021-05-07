class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method,       null: false, default: 0
      t.integer :status        ,       null: false, default: 0
      t.integer :customer_id

      t.timestamps
    end
  end
end
