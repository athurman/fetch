class Group
  attr_accessor :name
  attr_reader :id

  def initialize name
    self.name = name
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from groups order by group_name ASC")
    results.map do |row_hash|
      group = Group.new(row_hash["group_name"])
      group.send("id=", row_hash["id"])
      group
    end
  end

  def self.find name
    database = Environment.database_connection
    database.results_as_hash = true
    group = Group.new(name)
    results = database.execute("select * from groups where group_name = '#{group.name}'")
    if results.empty?
      "NULL"
    else
      row_hash = results[0]
      group.send("id=", row_hash["id"])
    end
    group
  end

  protected

  def id=(id)
    @id = id
  end

end