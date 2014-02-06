require 'httparty'
require 'json'
require_relative './lib/environment.rb'

environment = Environment.environment = "test"

puts environment

class JsonParser
  BASEURL = 'http://api.petfinder.com/'

  def self.parse_breeds
    breeds = File.read("breeds.json")
    breeds_hash = JSON.parse(breeds)
    breeds_hash["breeds"].each do |breed_obj|
      name = breed_obj["breed_name"]
      group = Group.find(breed_obj["group"])
      role = Role.find(breed_obj["role"])
      name.each_char do |char|
        if char == "'"
          name.delete!(char)
        end
      end
      breed = Breed.create(name: name, size: breed_obj["size"], lifespan: breed_obj["lifespan"],
                           weight: breed_obj["weight"], height: breed_obj["height"], group_id: group.id,
                           exercise: breed_obj["exercise"], grooming: breed_obj["grooming"],
                           family_friendly: breed_obj["family_friendly"], role_id: role.id,
                           temperament: breed_obj["temperament"])
    end
  end

  def self.parse_shelterdogs
    response = HTTParty.get(BASEURL + 'pet.find?key=c75009674079754cf0b3a9551492bbb3&animal=dog&location=37218&count=5&format=json&token=95161f1daa0b100070ceb16cfe757aeb&sig=d6b2a331f1256cc4bb1e28bcb98d7b14')
    shelter_dogs_ary = JSON.parse(response.body)
    shelter_dogs_ary["petfinder"]["pets"]["pet"].each do |dog_hash|
      shelter = dog_hash["shelterId"]["$t"]
      if dog_hash["breeds"]["breed"].is_a?(Array)
        breed = dog_hash["breeds"]["breed"][0]["$t"]
      else
        breed = dog_hash["breeds"]["breed"]["$t"]
      end
      shelterdog_breed = Breed.find_by_name(breed)
      shelterdog = ShelterDog.create(name: dog_hash["name"]["$t"], breed_id: shelterdog_breed.id,
                                     shelter: shelter, age: dog_hash["age"]["$t"],
                                     weight: dog_hash["size"]["$t"], status: dog_hash["status"]["$t"])
    end
  end

  def self.parse_roles
    roles = ["Companion Dog", "Guard Dog", "Show Dog", "Hunting", "Herding"]
    roles.each do |role|
      Role.create(role)
    end
  end

  def self.parse_groups
    groups = ["Herding", "Hound", "Non-Sporting", "Sporting", "Terrier", "Toy", "Working"]
    groups.each do |group|
      Group.create(group)
    end
  end
end