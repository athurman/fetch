require_relative 'helper'
require_relative '../models/shelterdog'

class TestShelterDog < FetchTest
  def test_to_s_prints_details
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    expected = "#{fido.id}. Fido:\n  breed: Collie\n  shelter: Humane Society\n  age: young\n  weight: M\n  status: A"
    assert_equal expected, fido.to_s
  end

  def test_saved_shelter_dogs_are_saved
    fido_before = Shelterdog.count
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    fido_after = Shelterdog.count
    assert_equal fido_before + 1, fido_after
  end

  def test_all_returns_empty_array_if_no_shelter_dogs
    results = Shelterdog.all
    assert_equal [], results
  end

  def test_update_is_reflected_in_existing_instance
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    fido.update(name: "Rover")
    expected = ["Rover", "Collie", "Humane Society", "young", "M", "A" ]
    actual = [fido.name, fido.breed, fido.shelter, fido.age, fido.weight, fido.status]
    assert_equal expected, actual
  end

  def test_update_doesnt_insert_new_row
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    dogs_before = Shelterdog.count
    fido.update(name: "Rover")
    dogs_after = Shelterdog.count
    assert_equal dogs_before, dogs_after
  end

  def test_delete_method_removes_dog
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    spot = Shelterdog.create(name: "Spot", breed: "Cocker Spaniel",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    dogs_before = Shelterdog.count
    fido = Shelterdog.find_by(id: fido.id)
    fido.destroy
    dogs_after = Shelterdog.count
    assert_equal dogs_before - 1, dogs_after
  end

  def test_cant_find_dog_after_it_is_deleted
    fido = Shelterdog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    fido = Shelterdog.find_by(id: fido.id)
    fido.destroy
    result = Shelterdog.find_by(name: fido.name)
    assert_nil result
  end

  def test_search_shelterdogs_by_breed_name
    spot = Shelterdog.create(name: "Spot", breed: "Australian Terrier",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    fido = Shelterdog.create(name: "Fido", breed: "Australian Terrier",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    ruby = Shelterdog.create(name: "Ruby", breed: "German Shepherd",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    shelterdogs = Shelterdog.where(breed: "Australian Terrier")
    assert_equal ["Fido", "Spot"], shelterdogs.map{ |dog| dog.name}
  end

  def test_search_shelterdogs_by_breed_name_returns_empty_array
    spot = Shelterdog.create(name: "Spot", breed: "Australian Terrier",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    fido = Shelterdog.create(name: "Fido", breed: "Australian Terrier",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    ruby = Shelterdog.create(name: "Ruby", breed: "German Shepherd",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    shelterdogs = Shelterdog.where(breed: "Labrador Retriever")
    assert_equal [], shelterdogs
  end
end