class CreateSavedTests < ActiveRecord::Migration
  def change
    create_table :saved_tests do |t|
      t.integer :user_id
      t.string :result, default: "You have not completed test"
      t.string :test_type

      t.timestamps
    end
  end
end
