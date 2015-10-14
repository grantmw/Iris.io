class CreateSavedTests < ActiveRecord::Migration
  def change
    create_table :saved_tests do |t|
      t.integer :user_id
      t.string :result_both, default: "No saved tests"
      t.string :result_left, default: "No saved tests"
      t.string :result_right, default: "No saved tests"
      t.string :result_cb, default: "No saved tests"
      t.string :test_type

      t.timestamps
    end
  end
end
