class Breed < ActiveRecord::Base
  belongs_to :role
  belongs_to :group

  def to_s
    "#{id}. #{name}:\nSize: #{size}\nLifespan: #{lifespan}\nAverage Weight: #{weight}\nAverge Height: #{height}\nGroup: #{group.name}\nExercise: #{exercise}\nGrooming? #{grooming}\nFamily Friendly? #{family_friendly}\nTemperament: #{temperament}"
  end

  def self.return_exercise id
    exercises = Breed.select(:exercise).distinct.where(role_id: id)
    exercises = exercises.map{ |breed| breed.exercise}
  end

  def self.find_top_five(role_id, exercise, grooming, family_friendly)
    if family_friendly == "no" && grooming == "yes"
      results = Breed.where("role_id = #{role_id} and exercise = '#{exercise}'").limit(10)
    elsif family_friendly == "no"
      results = Breed.where("role_id = #{role_id} and exercise = '#{exercise}' and grooming = '#{grooming}'").limit(10)
    elsif grooming == "yes"
      results = Breed.where("role_id = #{role_id} and exercise = '#{exercise}' and family_friendly = '#{family_friendly}'").limit(10)
    else
      results = Breed.where("role_id = #{role_id} and exercise = '#{exercise}' and grooming = '#{grooming}' and family_friendly = '#{family_friendly}'").limit(10)
          end
    results
  end

end