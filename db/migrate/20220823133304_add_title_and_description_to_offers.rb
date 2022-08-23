class AddTitleAndDescriptionToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :title, :string
    add_column :offers, :description, :text
  end
end
