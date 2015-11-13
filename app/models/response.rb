# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question
  validate :respondent_did_not_author_question

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id


  has_one :question, through: :answer_choice, source: :question

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: user_id)
      errors[:base] << "Respondent already answered Question"
    end
  end

  def sibling_responses
    if self.id.nil?
      self.question.responses
    else
      self.question.responses.where('responses.id != ?', self.id)
    end
  end

  def respondent_did_not_author_question
    if question.poll.author_id == self.user_id
      errors[:base] << "Author can't respond to own poll"
    end
  end
end
