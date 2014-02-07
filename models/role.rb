class Role < ActiveRecord::Base
  default_scope { order("name ASC") }
end