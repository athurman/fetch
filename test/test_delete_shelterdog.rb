require_relative 'helper'

class TestShelterDogDelete < FetchTest
  def test_deletes_all_dogs_with_name_fido_plus_id
    fido1 = Shelterdog.create(name: "Fido", breed: "Standard Poodle",
                           shelter: "Humane Society", age: "adult",
                           weight: "M", status: "A")
    fido1_id = fido1.id
    fido2 = Shelterdog.create(name: "Fido", breed: "Collie",
                           shelter: "Shamrock", age: "young",
                           weight: "M", status: "A")
    fido2_id = fido2.id
    spot = Shelterdog.create(name: "Spot", breed: "Dalmation",
                             shelter: "Humane Society", age: "adult",
                             weight: "M", status: "A")
    spot_id = spot.id

    shell_output = ""
    IO.popen('./fetchdog delete Fido --environment test', 'r+') do |pipe|
      pipe.puts("#{fido1_id}")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Dog #{fido1_id}. Fido has beend deleted from the shelterdogs table"
  end
end