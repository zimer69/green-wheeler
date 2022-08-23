class AddElectricAndSafetyEquipmentAndOptionalToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :electric, :boolean
    add_column :offers, :safety_equipment, :boolean
  end
end
