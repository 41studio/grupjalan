class AddCountryCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :string, :limit => 2
  end
end
