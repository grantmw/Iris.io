class CreateVisions < ActiveRecord::Migration
  def change
    create_table :visions do |t|
      t.string :level
      t.decimal :font_size

      t.timestamps null: false
    end
  end
end
