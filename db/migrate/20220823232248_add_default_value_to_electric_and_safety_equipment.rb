class AddDefaultValueToElectricAndSafetyEquipment < ActiveRecord::Migration[7.0]
  def change
    change_column_default :offers, :electric, false
    change_column_default :offers, :safety_equipment, false
  end
end
