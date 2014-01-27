class ShelterDog
  attr_accessor :name, :breed, :shelter, :age, :weight, :status
  attr_reader :id

  def initialize attributes = {}
    [:name, :breed, :shelter, :age, :weight, :status].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def to_s
    "#{id}. #{name}:\n  breed: #{breed}\n  shelter: #{shelter}\n  age: #{age}\n  weight: #{weight}\n  status: #{status}"
  end

  def save
    database = Environment.database_connection
    database.execute("insert into shelterdogs(name, breed, shelter, age, weight, status)
                     values('#{name}', '#{breed}', '#{shelter}', '#{age}', '#{weight}', '#{status}')")
    @id = database.last_insert_row_id
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelterdogs order by name ASC")
    results.map do |row_hash|
      shelterdog = ShelterDog.new(name: row_hash["name"], breed: row_hash["breed"],
                                  shelter: row_hash["shelter"], age: row_hash["age"],
                                  weight: row_hash["weight"], status: row_hash["status"])
      shelterdog.send("id=", row_hash["id"])
      shelterdog
    end
  end

  def self.create(attributes = {})
    shelterdog = ShelterDog.new(attributes)
    shelterdog.save
    shelterdog
  end

  def self.search
    puts "Needs to be Implemented"
  end

  def update
    puts "Needs to be Implemented"
  end

  protected

  def id=(id)
    @id = id
  end
end