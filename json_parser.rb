require 'httparty'
require 'json'
require_relative '../models/shelterdog.rb'
require_relative '../models/group.rb'
require_relative '../models/role.rb'
require_relative '../models/breed.rb'
require_relative '../lib/environment.rb'

environment = Environment.environment = "test"

class JsonParser
  BASEURL = 'http://api.petfinder.com/'

  def self.parse_breeds
    breeds = File.read("../breeds.json")
    breeds_hash = JSON.parse(breeds)
    breeds_hash["breeds"].each do |breed_obj|
      name = breed_obj["breed_name"].dump
      size = breed_obj["size"]
      lifespan = breed_obj["lifespan"].dump
      weight = breed_obj["weight"].dump
      height = breed_obj["height"].dump
      group = Group.find(breed_obj["group"])
      exercise = breed_obj["exercise"]
      grooming = breed_obj["grooming"]
      family_friendly = breed_obj["family_friendly"]
      role = Role.find(breed_obj["role"])
      temperament = breed_obj["temperament"].dump

      breed = Breed.create(name: name, size: size, lifespan: lifespan,
                           weight: weight, height: height, group_id: group.id,
                           exercise: exercise, grooming: grooming, family_friendly: family_friendly,
                           role_id: role.id, temperament: temperament)
    end
  end

  def self.parse_shelterdogs
    response = HTTParty.get(BASEURL + 'pet.find?key=c75009674079754cf0b3a9551492bbb3&animal=dog&location=37218&count=5&format=json&token=95161f1daa0b100070ceb16cfe757aeb&sig=d6b2a331f1256cc4bb1e28bcb98d7b14')
    shelter_dogs_ary = JSON.parse(response.body)
    shelter_dogs_ary["petfinder"]["pets"]["pet"].each do |dog_hash|

      name =  dog_hash["name"]["$t"]
      status =  dog_hash["status"]["$t"]
      age =  dog_hash["age"]["$t"]
      weight = dog_hash["size"]["$t"]
      shelter = dog_hash["shelterId"]["$t"]
      if dog_hash["breeds"]["breed"].is_a?(Array)
        breed = dog_hash["breeds"]["breed"][0]["$t"]
      else
        breed = dog_hash["breeds"]["breed"]["$t"]
      end
      shelterdog_breed = Breed.find_by_name(breed)
      shelterdog = ShelterDog.create(name: name, breed_id: shelterdog_breed.id,
                                     shelter: shelter, age: age,
                                     weight: weight, status: status)
    end
  end
end