require_relative 'helper'

class TestEnteringDog < Minitest::Unit::TestCase

  # Ask about adding a space between "Humane" and "Society" in OptionParser method

  def test_valid_dog_information_gets_printed
    command = "./fetchdog add Fido --breed Collie --shelter HumaneSociety --age 2 --weight 85 --status A"
    expected = "Theoretically creating: a dog named Fido, breed: Collie, shelter: HumaneSociety, age: 2 weight: 85 lbs. with an A status for adoptable"
    assert_command_output expected, command
  end

  def test_valid_dog_gets_saved
    skip "needs implementation"
  end

  def test_invalid_dog_does_not_get_saved
    skip "needs implementation"
  end

  def test_error_message_for_missing_age
    result = "./fetchdog add Fido --breed Collie --shelter HumaneSociety"
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
    expected = "You must provide the name of the dog you are adding."
    assert_command_output expected, result
  end
end