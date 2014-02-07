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

  def self.search_by_name dog_name
    database = Environment.database_connection
    results = database.execute("select shelterdogs.id, shelterdogs.name from shelterdogs where name LIKE '%#{dog_name}%'")
    if results.empty?
      return "The dog you were searching for is not found"
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

  def self.search_by_id id
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

  def self.find_by_breedname breed_name
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from shelterdogs where breed = '#{breed_name}' order by name ASC")
    results_as_hash = false
    shelterdogs = []
    unless results.empty?
      row_hash = results
      i = 0
      results.each do |breed|
        shelterdog = ShelterDog.new(name: results[i]["name"], breed: results[i]["breed"],
                                  shelter: results[i]["shelter"], age: results[i]["age"],
                                  weight: results[i]["weight"], status: results[i]["status"])
        shelterdog.send("id=", results[i]["id"])
        shelterdogs << shelterdog
        i = i +1
      end
    end
    shelterdogs
  end

  def self.count
    database = Environment.database_connection
    total = database.execute("select count(id) from shelterdogs")[0][0]
  end

  def self.create(attributes = {})
    shelterdog = ShelterDog.new(attributes)
    shelterdog.save
    shelterdog
  end

  def update selection, info, id
    database = Environment.database_connection
    database.execute("update shelterdogs set '#{selection}' = '#{info}' where id = #{id}")
    ShelterDog.search_by_id(id)
  end

  def self.delete id
    database = Environment.database_connection
    database.execute("delete from shelterdogs where shelterdogs.id = #{id}")
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