class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :grill, default: false, null: false
      t.boolean :line, default: false, null: false
      t.boolean :juice, default: false, null: false
      t.boolean :cashier, default: false, null: false
      t.boolean :baking, default: false, null: false
      t.boolean :coldpress, default: false, null: false

      t.timestamps
    end
  end
end
