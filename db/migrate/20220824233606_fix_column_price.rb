class FixColumnPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :offers, :price_in_cents, :price
  end
end
