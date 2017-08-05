class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.boolean :cash, default: false
      t.datetime :start_time
      t.datetime :end_time
      t.integer  :user_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
