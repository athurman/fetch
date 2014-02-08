class Shelterdog < ActiveRecord::Base
  default_scope { order("name ASC") }

  def to_s
    "#{id}. #{name}:\n  breed: #{breed}\n  shelter: #{shelter}\n  age: #{age}\n  weight: #{weight}\n  status: #{status}"
  end
end