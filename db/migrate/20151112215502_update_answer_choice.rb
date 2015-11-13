class UpdateAnswerChoice < ActiveRecord::Migration

  def change
    drop_table :answer_choices
    create_table :answer_choices do |t|
      t.text :text
      t.integer :question_id

      t.timestamps
    end
  end
end
