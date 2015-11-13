class UpdateResponse < ActiveRecord::Migration
  def change
    drop_table :responses
    create_table :responses do |t|
      t.integer :answer_choice_id
      t.integer :user_id

      t.timestamps
    end
  end
end
