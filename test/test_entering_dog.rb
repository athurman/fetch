require_relative 'helper'
require 'sqlite3'

class TestEnteringDog < FetchTest

  def test_valid_dog_information_gets_printed
    command = "./fetchdog add Fido --breed Collie --shelter 'Humane Society' --age 2 --weight 85 --status A"
    expected = "A shelter dog named Fido, breed: Collie, shelter: Humane Society, age: 2 weight: 85 lbs. with status of A."
    assert_command_output expected, command
  end

  def test_valid_dog_gets_saved
    `./fetchdog add Fido --breed Collie --shelter 'Humane Society' --age 2 --weight 85 --status A --environment test`

    results = database.execute("select name, breed, shelter, age, weight, status from shelterdogs")
    expected = ["Fido", "Collie", "Humane Society", 2, 85, "A"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from shelterdogs")
    assert_equal 1, result[0][0]
  end

  def test_invalid_dog_does_not_get_saved
    `./fetchdog add Fido --breed Boxer`
    result = database.execute("select count(id) from shelterdogs")
    assert_equal 0, result[0][0]
  end

  def test_error_message_for_missing_age
    result = "./fetchdog add Fido --breed Collie --shelter 'Humane Society'"
    expected = "You must provide the age and weight and status of the dog you are adding."
    assert_command_output expected, result
  end

  def test_error_message_for_missing_shelter_name
    result = "./fetchdog add Fido --breed Collie"
    expected = "You must provide the shelter and age and weight and status of the dog you are adding."
    assert_command_output expected, result
  end

  def test_error_message_for_missing_breed_name
    result = "./fetchdog add Fido"
    expected = "You must provide the breed and shelter and age and weight and status of the dog you are adding."
    assert_command_output expected, result
  end

  def test_error_message_for_missing_name
    result = "./fetchdog add"
    expected = "You must provide the name of the dog you are adding.\nYou must provide the breed and shelter and age and weight and status of the dog you are adding."
    assert_command_output expected, result
  end
end