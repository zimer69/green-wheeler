class AddRatingAndUserTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rating, :float
    add_column :users, :user_type, :string
  end
end
