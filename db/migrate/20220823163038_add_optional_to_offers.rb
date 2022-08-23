class AddOptionalToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :optional, :string
  end
end
