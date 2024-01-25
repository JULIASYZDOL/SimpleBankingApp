class ChangeCharacterPositionsTypeInPasswordCombinations < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:password_combinations)
      change_column :password_combinations, :character_positions, :text
    else
      create_table :password_combinations do |t|
        t.string :combination
        t.text :character_positions
        t.references :user, foreign_key: true

        t.timestamps
      end
    end
  end
end
