class CreateSavedTests < ActiveRecord::Migration
  def change
    create_table :saved_tests do |t|
      t.integer :user_id
      t.string :result_both
      t.string :result_left
      t.string :result_right
      t.string :result_cb
      t.string :test_type

      t.timestamps null: false
    end
  end
end
