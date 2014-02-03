require_relative 'helper'
require_relative '../models/group'

class TestGroup < FetchTest
  def test_all_method_prints_all_groups
    actual = Group.all.map{ |group| group.name }
    expected = ["Herding", "Hound", "Non-Sporting", "Sporting", "Terrier", "Toy", "Working"]
    assert_equal expected, actual
  end

  def test_find_method_returns_proper_group
    group = Group.find("Toy")
    assert_equal 8, group.id
    assert_equal "Toy", group.name
  end

  def test_find_method_returns_id_from_table_end
    group = Group.find("Herding")
    assert_equal 4, group.id
  end

  def test_find_by_id_from_table
    group = Group.find_by_id(4)
    assert_equal "Herding", group.name
    assert_equal 4, group.id
  end
end