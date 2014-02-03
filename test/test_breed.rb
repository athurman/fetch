require_relative 'helper'
require_relative '../models/breed'

class TestBreed < FetchTest
  def test_find_by_name_method_returns_breed_name
    mountain_dog = Breed.find_by_name("Bernese Mountain Dog")
    assert_equal "Bernese Mountain Dog", mountain_dog.name
  end

  def test_find_by_name_method_returns_breed_size
    mountain_dog = Breed.find_by_name("Australian Kelpie")
    assert_equal "M", mountain_dog.size
  end

  def test_to_s_prints_breed_details
    akita = Breed.find_by_name("Akita")
    expected = "#{akita.id}. Akita:\nSize: L\nLifespan: 10 to 12 years\nAverage Weight: 75 to 110 lbs.\nAverge Height: 24 to 28 inches\nGroup: Working\nExercise: Moderate\nGrooming? yes\nFamily Friendly? yes\nTemperament: The Akita is a bold, independent and stubborn breed."
    assert_equal expected, akita.to_s
  end

  def test_search_breeds_by_role
    breeds = Breed.find_by_role(2)
    expected = ["Airedale Terrier", "American Bulldog", "American Staffordshire Terrier", "Anatolian Shepherd", "Belgian Shepherd Malinois", "Blue Lacy", "Bullmastiff", "Cane Corso Mastiff"]
    assert_equal expected, breeds.map{ |breed| breed.name}
  end

  def test_find_breeds_and_return_exercise
    role_id = 2
    exercises = Breed.return_exercise(role_id)
    assert_equal ["Daily", "Moderate"], exercises
  end

  def test_return_top_ten_breeds
    role_id = 1
    exercise = "Moderate"
    grooming = "yes"
    family_friendly = "yes"
    breeds = Breed.find_top_five(role_id, exercise, grooming, family_friendly)
    expected = ["Akita", "American Eskimo Dog", "Appenzell Mountain Dog", "Australian Terrier", "Basset Hound", "Beagle", "Bearded Collie", "Bedlington Terrier", "Belgian Shepherd Dog Sheepdog", "Belgian Shepherd Tervuren"]
    assert_equal expected, breeds.map{ |breed| breed.name}
  end

  def test_return_top_ten_breeds_if_family_friendly_no
    role_id = 1
    exercise = "Moderate"
    grooming = "yes"
    family_friendly = "no"
    breeds = Breed.find_top_five(role_id, exercise, grooming, family_friendly)
    expected = ["Akita", "American Eskimo Dog", "Appenzell Mountain Dog", "Australian Terrier", "Basset Hound", "Beagle", "Bearded Collie", "Bedlington Terrier", "Belgian Shepherd Dog Sheepdog", "Belgian Shepherd Tervuren"]
    assert_equal expected, breeds.map{ |breed| breed.name}
  end

  def test_return_top_five_breeds_if_grooming_yes
    role_id = 2
    exercise = "Moderate"
    grooming = "yes"
    family_friendly = "yes"
    breeds = Breed.find_top_five(role_id, exercise, grooming, family_friendly)
    expected = ["American Bulldog", "Anatolian Shepherd", "Belgian Shepherd Malinois"]
    assert_equal expected, breeds.map{ |breed| breed.name}
  end
end