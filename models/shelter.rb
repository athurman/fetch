class Shelter
  attr_accessor :name, :location, :petfinder_id
  attr_reader :id

  def initialize attributes = {}
    [:name, :location, :petfinder_id].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.find_by_petfinder_id petfinder_id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelters where petfinder_id = '#{petfinder_id}'")
    database.results_as_hash = false
    if results.empty?
      shelter = "Unable to find shelter. Please try again."
    else
      row_hash = results[0]
      shelter = Shelter.new(name: row_hash["name"],
                            location: row_hash["location"],
                            petfinder_id: row_hash["petfinder_id"])
      shelter.send("id=", row_hash["id"])
    end
    shelter
  end

  def self.calculate_popular_breed id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("Select shelterdogs.breed, Count(*) From shelterdogs Where shelterdogs.shelter = '#{id}' GROUP BY shelterdogs.breed ORDER BY COUNT(*) DESC")
    database.results_as_hash = false
    results[0]
  end

  def self.calculate_total_dogs id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("Select Count(*) From shelterdogs Where shelterdogs.shelter = '#{id}'")
    database.results_as_hash = false
    results[0]
  end

  def self.find_by_location zip_code
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelters where location = '#{zip_code}'")
    database.results_as_hash = false
    shelters = []
    unless results.empty?
      row_hash = results
      i = 0
      results.each do |shelter|
        shelter = Shelter.new(name: row_hash[i]["name"],
                              location: row_hash[i]["location"],
                              petfinder_id: row_hash[i]["petfinder_id"])
        shelter.send("id=", row_hash[i]["id"])
        shelters << shelter
        i = i + 1
      end
    end
    shelters
  end

  def self.calculate_rate(id, status)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select Count(*) from shelterdogs Where shelterdogs.shelter = '#{id}' and shelterdogs.status = '#{status}'")
    database.results_as_hash = false
    status_total = results[0][0]
    total_amt_of_dogs = Shelter.calculate_total_dogs(id)
    total_amt_of_dogs = total_amt_of_dogs["Count(*)"]
    rate = status_total.to_f / total_amt_of_dogs.to_f
    rate = (rate * 100).round.to_s + '%'
  end

  protected

  def id=(id)
    @id = id
  end
end