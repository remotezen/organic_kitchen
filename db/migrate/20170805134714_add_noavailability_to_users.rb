class AddNoavailabilityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :noavailability, :string, default: "any"
  end
end
