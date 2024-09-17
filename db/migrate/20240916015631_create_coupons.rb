class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :title
      t.text :description
      t.string :code
      t.datetime :expires_at

      t.timestamps
    end
  end
end
