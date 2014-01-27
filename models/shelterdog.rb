class ShelterDog
  attr_accessor :name, :breed, :shelter, :age, :weight, :status
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
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

  def self.search input
    database = Environment.database_connection
    statement = "select shelterdogs.id, shelterdogs.name from shelterdogs where name LIKE '%#{input}%'"
    results = database.execute(statement)
    if results.empty?
      puts "The dog you were searching for is not found"
      exit
    else
      i = 0
      results.each do
        id = results[i][0]
        name = results[i][1]
        puts "#{id}. #{name}"
        i = i + 1
      end
    end
  end

  def self.find_by_id id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelterdogs where id LIKE '#{id}'")[0]
    if results
      shelterdog = ShelterDog.new(name: results["name"], breed: results["breed"],
                                  shelter: results["shelter"], age: results["age"],
                                  weight: results["weight"], status: results["status"])
      shelterdog.send("id=", results["id"])
      shelterdog
    else
      nil
    end
  end

  def self.create(attributes = {})
    shelterdog = ShelterDog.new(attributes)
    shelterdog.save
    shelterdog
  end

  def update selection, info, id
    database = Environment.database_connection
    database.execute("update shelterdogs set '#{selection}' = '#{info}' where id = #{id}")
    ShelterDog.find_by_id(id)
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :breed, :shelter, :age, :weight, :status].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end
end