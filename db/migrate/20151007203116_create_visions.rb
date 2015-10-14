class CreateVisions < ActiveRecord::Migration
  def change
    create_table :visions do |t|
      t.string :level
      t.decimal :font_size
    end
  end
end
