class AddTokensToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :access_token, :string
    add_column :users, :client, :string
    add_column :users, :expiry, :integer
  end
end
