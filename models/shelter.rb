class Shelter < ActiveRecord::Base
  default_scope { order("name ASC") }

  def self.calculate_popular_breed id
    results = Shelterdog.find_by_sql("select shelterdogs.breed, Count(*) as total from shelterdogs where shelterdogs.shelter = '#{id}' group by shelterdogs.breed order by total desc")
    results
  end

  def self.calculate_total_dogs id
    results = Shelterdog.where(shelter: id).count
  end

  def self.calculate_rate(id, status)
    results = Shelterdog.where(shelter: id).where(status: status).count
    status_total = results
    total_amt_of_dogs = Shelter.calculate_total_dogs(id)
    rate = status_total.to_f / total_amt_of_dogs.to_f
    rate = (rate * 100).round.to_s + '%'
  end
end