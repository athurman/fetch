require_relative 'helper'

class TestUpdateShelterDog < FetchTest
  def test_lists_all_dogs_with_name_fido_plus_id
    fido1 = Shelterdog.create(name: "Fido", breed: "Standard Poodle",
                           shelter: "Humane Society", age: "adult",
                           weight: "M", status: "A")
    fido1_id = fido1.id
    fido2 = Shelterdog.create(name: "Fido", breed: "Collie",
                           shelter: "Shamrock", age: "young",
                           weight: "M", status: "A")
    fido2_id = fido2.id

    shell_output = ""
    IO.popen('./fetchdog update Fido --environment test', 'r+') do |pipe|
      pipe.puts("#{fido1_id}")
      pipe.puts("status")
      pipe.puts("X")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Dog #{fido1_id} is now named Fido, breed is Standard Poodle, shelter is Humane Society, age is adult, weight is M, and status is X"
  end

  def test_message_given_when_wrong_id_input_by_user
     fido1 = Shelterdog.create(name: "Fido", breed: "Standard Poodle",
                           shelter: "Humane Society", age: "adult",
                           weight: "M", status: "A")
    fido1_id = fido1.id
    fido2 = Shelterdog.create(name: "Fido", breed: "Collie",
                           shelter: "Shamrock", age: "young",
                           weight: "M", status: "A")
    fido2_id = fido2.id

    shell_output = ""
    IO.popen('./fetchdog update Fido --environment test', 'r+') do |pipe|
      pipe.puts("2244")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "No dogs were found with that id, please try again."
  end
end