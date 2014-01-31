class Breed
  attr_accessor :name, :size, :lifespan, :weight, :height, :group_id, :exercise, :grooming, :family_friendly, :role_id, :temperament
  attr_reader :id

  def initialize attributes = {}
    [:name, :size, :lifespan, :weight, :height, :group_id, :exercise, :grooming, :family_friendly, :role_id, :temperament].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end



  def save
    database = Environment.database_connection
    database.execute("insert into breeds(name, size, lifespan, weight, height, group_id, exercise, grooming, family_friendly, role_id, temperament) values('#{name}', '#{size}', '#{lifespan}', '#{weight}', '#{height}', '#{group_id}', '#{exercise}', '#{grooming}', '#{family_friendly}', '#{role_id}', '#{temperament}')")
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
    results = database.execute("select * from breeds where name like '%#{breed_name}%'")
    if results.empty?
      breed = "Unable to find breed"
    else
      row_hash = results[0]
      breed = Breed.new(name: row_hash["name"], size: row_hash["breed"], lifespan: row_hash["lifespan"],
                weight: row_hash["weight"], height: row_hash["height"], group_id: row_hash["group_id"],
                exercise: row_hash["exercise"], grooming: row_hash["grooming"], family_friendly: row_hash["family_friendly"],
                role_id: row_hash["role_id"], temperament: row_hash["temperament"])
      breed.send("id=", row_hash["id"])
    end
    breed
  end

  protected

  def id=(id)
    @id = id
  end
end