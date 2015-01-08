class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.boolean :glasses
      t.string :re_indicator
      t.float :re_value
      t.string :le_indicator
      t.float :le_value
      t.string :re_indicator_extra, null: true
      t.float :re_value_extra,      null: true
      t.string :le_indicator_extra, null: true
      t.float :le_value_extra,      null: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :prescriptions, [:user_id, :created_at]
  end
end
