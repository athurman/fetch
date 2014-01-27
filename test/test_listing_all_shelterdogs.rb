require_relative 'helper'

class TestListingPurchases < FetchTest
  def test_lists_all_results
    fido = ShelterDog.create(name: "Fido", breed: "Collie",
                             shelter: "Humane Society", age: "young",
                             weight: "M", status: "A")
    spot = ShelterDog.create(name: "Spot", breed: "Dalmation",
                             shelter: "Humane Society", age: "adult",
                             weight: "M", status: "A")
    rover = ShelterDog.create(name: "Rover", breed: "Boxer",
                              shelter: "Humane Society", age: "young",
                              weight: "M", status: "A")

    command = "./fetchdog list"
    expected = <<EOS.chomp
All Shelter Dogs:
#{fido.id}. Fido:
  breed: Collie
  shelter: Humane Society
  age: young
  weight: M
  status: A
#{rover.id}. Rover:
  breed: Boxer
  shelter: Humane Society
  age: young
  weight: M
  status: A
#{spot.id}. Spot:
  breed: Dalmation
  shelter: Humane Society
  age: adult
  weight: M
  status: A
EOS
    assert_command_output expected, command
  end
end