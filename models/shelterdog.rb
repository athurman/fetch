class ShelterDog
  attr_accessor :name, :breed, :shelter, :age, :weight, :status

  def initialize attributes = {}
    [:name, :breed, :shelter, :age, :weight, :status].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def to_s
    "#{name}:\n  breed: #{breed}\n  shelter: #{shelter}\n  age: #{age}\n  weight: #{weight}\n  status: #{status}"
  end

  def save
    database = Environment.database_connection
    database.execute("insert into shelterdogs(name, breed, shelter, age, weight, status) values('#{name}', '#{breed}', '#{shelter}', '#{age}', '#{weight}', '#{status}')")
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelterdogs")
    results.map do |row_hash|
      ShelterDogs.new(name: row_hash["name"], price: row_hash["price"], calories: row_hash["calories"])
    end
  end

  def self.create
    puts "Needs to be Implemented"
  end

  def self.search
    puts "Needs to be Implemented"
  end

  def update
    puts "Needs to be Implemented"
  end
end