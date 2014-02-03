class Role
  attr_accessor :name
  attr_reader :id

  def initialize name
    self.name = name
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from roles order by name ASC")
    if results.empty?
      "No results found"
    else
      results.map do |row_hash|
        role = Role.new(row_hash["name"])
        role.send("id=", row_hash["id"])
        role
      end
    end
  end

  def self.find name
    database = Environment.database_connection
    database.results_as_hash = true
    role = Role.new(name)
    results = database.execute("select * from roles where name = '#{role.name}'")
    if results.empty?
      "NULL"
    else
      row_hash = results[0]
      role.send("id=", row_hash["id"])
    end
    role
  end

  protected

  def id=(id)
    @id = id
  end

end