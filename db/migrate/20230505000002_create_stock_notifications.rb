class CreateStockNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_notifications do |t|
      t.string :email, null: false
      t.references :product, null: false, foreign_key: true
      t.datetime :notified_at

      t.timestamps
    end
    
    add_index :stock_notifications, [:product_id, :email], unique: true
  end
end
