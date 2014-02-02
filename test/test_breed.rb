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
    expected = "#{akita.id}. Akita:\nSize: L\nLifespan: 10 to 12 years\nAverage Weight: 75 to 110 lbs.\n
    Averge Height: 24 to 28 inches\nGroup: 6\nExercise: Moderate\nGrooming? yes\n
    Family Friendly? yes\nTemperament: The Akita is a bold, independent and stubborn breed."
    assert_equal expected, akita.to_s
  end

  def test_search_breeds_by_role
    breeds = Breed.find_by_role(2)
    expected = ["Airedale Terrier", "American Bulldog", "American Staffordshire Terrier", "Anatolian Shepherd", "Belgian Shepherd Malinois", "Blue Lacy", "Bullmastiff", "Cane Corso Mastiff"]
    assert_equal expected, breeds.map{ |breed| breed.name}
  end
end