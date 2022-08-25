class AddAddressToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :address, :string
  end
end
