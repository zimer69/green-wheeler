class RemoveFieldUserTypeFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_type, :string
  end
end
