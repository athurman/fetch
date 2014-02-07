require_relative 'helper'
require_relative '../models/role'

class TestRole < FetchTest
  def test_all_method_prints_all_roles
    actual = Role.all
    actual = actual.map{ |role| role.name }
    expected = ["Companion Dog", "Guard Dog", "Herding", "Hunting", "Show Dog"]
    assert_equal expected, actual
  end

  def test_find_method_returns_id
    role = Role.find_by(name: "Companion Dog")
    assert_equal 1, role.id
  end

  def test_find_method_returns_id_from_table_end
    role = Role.find_by(name: "Herding")
    assert_equal 5, role.id
  end
end