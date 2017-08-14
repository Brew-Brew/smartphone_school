class Subject < ActiveRecord::Base
 belongs_to :user
 has_many :quizzes

 has_many :scores
end
