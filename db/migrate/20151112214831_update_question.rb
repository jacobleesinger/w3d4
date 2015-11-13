class UpdateQuestion < ActiveRecord::Migration
  def change
    drop_table :questions
    create_table :questions do |t|
      t.text :text
      t.integer :poll_id

      t.timestamps
    end

  end
end
