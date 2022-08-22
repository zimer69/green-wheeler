class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :category
      t.integer :price_in_cents
      t.float :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
