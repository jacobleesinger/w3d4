# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :responses, through: :answer_choices, source: :responses

  def results_crap
    answer_choice_response_counts = {}

    answer_choices.all.each do |answer|
      answer_choice_response_counts[answer.text] = answer.responses.length
    end

    answer_choice_response_counts
  end

  def results
    answer_choices = self.answer_choices.includes(:responses)

    answer_choice_response_counts = {}
    answer_choices.each do |answer|
      answer_choice_response_counts[answer.text] = answer.responses.length
    end

    answer_choice_response_counts
  end

  def best_results

    # (<<-SQL)
    #   SELECT
    #     answer_choices.*, COUNT(responses.id) AS num_responses
    #   FROM
    #     answer_choices
    #   LEFT OUTER JOIN
    #     responses ON answer_choices.id = responses.answer_choice_id
    #   GROUP BY
    #     answer_choices.id
    #
    # SQL

end
