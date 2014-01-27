require_relative 'helper'
require_relative '../models/shelterdog'

class TestShelterDog < FetchTest
  def test_to_s_prints_details
    fido = ShelterDog.new(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    expected = "#{fido.id}. Fido:\n  breed: Collie\n  shelter: Humane Society\n  age: young\n  weight: M\n  status: A"
    assert_equal expected, fido.to_s
  end

  def test_saved_shelter_dogs_are_saved
    fido = ShelterDog.new(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    fido_before = database.execute("select count(id) from shelterdogs")[0][0]
    fido.save
    fido_after = database.execute("select count(id) from shelterdogs")[0][0]
    assert_equal fido_before + 1, fido_after
  end

  def test_all_returns_empty_array_if_no_shelter_dogs
    results = ShelterDog.all
    assert_equal [], results
  end

  def test_update_is_reflected_in_existing_instance
    fido = ShelterDog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    fido = fido.update("name", "Rover", "#{fido.id}")
    expected = ["Rover", "Collie", "Humane Society", "young", "M", "A" ]
    actual = [ fido.name, fido.breed, fido.shelter, fido.age, fido.weight, fido.status]
    assert_equal expected, actual
  end

  def test_update_doesnt_insert_new_row
    fido = ShelterDog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    dogs_before = database.execute("select count(id) from shelterdogs")[0][0]
    fido.update("name", "Rover", "#{fido.id}")
    dogs_after = database.execute("select count(id) from shelterdogs")[0][0]
    assert_equal dogs_before, dogs_after
  end

  def test_find_returns_nil_if_unfindable
    assert_nil ShelterDog.find_by_id(12342)
  end
end