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

end