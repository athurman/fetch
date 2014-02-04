require_relative 'group'

class Breed
  attr_accessor :name,
                :size,
                :lifespan,
                :weight,
                :height,
                :group,
                :exercise,
                :grooming,
                :family_friendly,
                :role_id,
                :temperament
  attr_reader :id

  def initialize attributes = {}
    @name = attributes[:name]
    @size = attributes[:size]
    @lifespan = attributes[:lifespan]
    @weight = attributes[:weight]
    @height = attributes[:height]
    @group = Group.find_by_id(attributes[:group_id])
    @exercise = attributes[:exercise]
    @grooming = attributes[:grooming]
    @family_friendly = attributes[:family_friendly]
    @role_id = attributes[:role_id]
    @temperament = attributes[:temperament]
  end

  def to_s
    "#{id}. #{name}:\nSize: #{size}\nLifespan: #{lifespan}\nAverage Weight: #{weight}\nAverge Height: #{height}\nGroup: #{group.name}\nExercise: #{exercise}\nGrooming? #{grooming}\nFamily Friendly? #{family_friendly}\nTemperament: #{temperament}"
  end

  def save
    database = Environment.database_connection
    database.execute("insert into breeds(name, size, lifespan, weight, height, group_id, exercise, grooming, family_friendly, role_id, temperament) values('#{name}', '#{size}', '#{lifespan}', '#{weight}', '#{height}', '#{group.id}', '#{exercise}', '#{grooming}', '#{family_friendly}', '#{role_id}', '#{temperament}')")
    @id = database.last_insert_row_id
  end

  def self.create(attributes = {})
    breed = Breed.new(attributes)
    breed.save
    breed
  end

  def self.find_by_name breed_name
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from breeds where name = '#{breed_name}'")
    database.results_as_hash = false
    if results.empty?
      breed = "Unable to find breed"
    else
      row_hash = results[0]
      # group = Group.find_by_id(row_hash["group_id"])
      breed = Breed.new(name: row_hash["name"], size: row_hash["size"], lifespan: row_hash["lifespan"],
                weight: row_hash["weight"], height: row_hash["height"], group_id: row_hash["group_id"],
                exercise: row_hash["exercise"], grooming: row_hash["grooming"], family_friendly: row_hash["family_friendly"],
                role_id: row_hash["role_id"], temperament: row_hash["temperament"])
      breed.send("id=", row_hash["id"])
    end
    breed
  end

  def self.find_by_role id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("SELECT * FROM breeds where breeds.role_id = #{id}")
    database.results_as_hash = false
    breeds = []
    unless results.empty?
      row_hash = results
      i = 0
      results.each do |breed|
        # group = Group.find_by_id(row_hash[i]["group_id"])
        breed = Breed.new(name: row_hash[i]["name"], size: row_hash[i]["size"], lifespan: row_hash[i]["lifespan"],
                  weight: row_hash[i]["weight"], height: row_hash[i]["height"], group_id: row_hash[i]["group_id"],
                  exercise: row_hash[i]["exercise"], grooming: row_hash[i]["grooming"], family_friendly: row_hash[i]["family_friendly"],
                  role_id: row_hash[i]["role_id"], temperament: row_hash[i]["temperament"])
        breed.send("id=", row_hash[i]["id"])
        breeds << breed
        i = i +1
      end
    end
    breeds
  end

  def self.return_exercise id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select distinct exercise from breeds where role_id = #{id}")
    database.results_as_hash = false
    row_hash = results
    exercises = []
    i = 0
    if results.empty?
      puts "No results found"
    else
      results.each do
        exercise = row_hash[i]["exercise"]
        exercises << exercise
        i = i +1
      end
    end
    exercises
  end

  def self.find_top_five(role_id, exercise, grooming, family_friendly)
    database = Environment.database_connection
    database.results_as_hash = true
    if family_friendly == "no" && grooming == "yes"
      results = database.execute("select * from breeds where role_id = #{role_id} and exercise = '#{exercise}' limit 10")
    elsif family_friendly == "no"
      results = database.execute("select * from breeds where role_id = #{role_id} and exercise = '#{exercise}' and grooming = '#{grooming}' limit 10")
    elsif grooming == "yes"
      results = database.execute("select * from breeds where role_id = #{role_id} and exercise = '#{exercise}' and family_friendly = '#{family_friendly}' limit 10")
    else
      results = database.execute("select * from breeds where role_id = #{role_id} and exercise = '#{exercise}' and grooming = '#{grooming}' and family_friendly = '#{family_friendly}' limit 10")
    end
    database.results_as_hash = false
    row_hash = results
    breeds = []
    i = 0
    if results.empty?
      puts "No results found"
    else
      results.each do
        # group = Group.find_by_id(row_hash[i]["group_id"])
        breed = Breed.new(name: row_hash[i]["name"], size: row_hash[i]["size"], lifespan: row_hash[i]["lifespan"],
                  weight: row_hash[i]["weight"], height: row_hash[i]["height"], group_id: row_hash[i]["group_id"],
                  exercise: row_hash[i]["exercise"], grooming: row_hash[i]["grooming"], family_friendly: row_hash[i]["family_friendly"],
                  role_id: row_hash[i]["role_id"], temperament: row_hash[i]["temperament"])
        breed.send("id=", row_hash[i]["id"])
        breeds << breed
        i = i +1
      end
    end
    breeds
  end

  protected

  def id=(id)
    @id = id
  end
end