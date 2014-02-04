require_relative 'helper'
require_relative '../models/shelter'

class TestShelter < FetchTest
  def test_find_by_location_method_returns_shelter_name
    shelters = Shelter.find_by_location(37027)
    expected = ["Noahs Ark Animal Hospital Rescues", "Middle Tennessee Boxer Rescue", "Westie Rescue SouthEast"]
    assert_equal expected, shelters.map{ |shelter| shelter.name}
  end

  def test_find_by_id_method_returns_shelter
    shelter = Shelter.find_by_petfinder_id("TN577")
    assert_equal "Robyns Nest Animal Rescue & Sanctuary", shelter.name
  end

  def test_calculate_most_popular_breed
    spot = ShelterDog.create(name: "Spot", breed: "Australian Terrier",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    fido = ShelterDog.create(name: "Fido", breed: "Australian Terrier",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    ruby = ShelterDog.create(name: "Ruby", breed: "German Shepherd",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    popular_breed = Shelter.calculate_popular_breed("TN546")
    assert_equal 2, popular_breed["Count(*)"]
  end

  def test_calculate_most_popular_breed_boxer
    spot = ShelterDog.create(name: "Spot", breed: "Boxer",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    fido = ShelterDog.create(name: "Fido", breed: "Australian Terrier",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    ruby = ShelterDog.create(name: "Ruby", breed: "Boxer",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    popular_breed = Shelter.calculate_popular_breed("TN546")
    assert_equal "Boxer", popular_breed["breed"]
  end

  def test_calculate_total_dogs_in_shelter
    spot = ShelterDog.create(name: "Spot", breed: "Boxer",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    fido = ShelterDog.create(name: "Fido", breed: "Australian Terrier",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    ruby = ShelterDog.create(name: "Ruby", breed: "Boxer",
                             shelter: "TN546", age: "young",
                             weight: "M", status: "A")
    total_dogs = Shelter.calculate_total_dogs("TN546")
    assert_equal = 3, total_dogs
  end
end