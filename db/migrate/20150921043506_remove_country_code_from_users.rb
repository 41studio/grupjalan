class RemoveCountryCodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :country_code, :string
  end
end
