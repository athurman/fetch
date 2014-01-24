require "sqlite3"

class Database < SQLite3::Database
  def self.connection(environment)
    @connection ||= Database.new("db/fetch_#{environment}.sqlite3")
  end
end