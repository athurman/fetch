require_relative 'helper'

class TestFindDogBreed < FetchTest
  def test_find_australian_terriers_in_shelter_from_top_5_dog_breeds
    fido1 = Shelterdog.create(name: "Fido", breed: "Australian Terrier",
                           shelter: "Humane Society", age: "adult",
                           weight: "M", status: "A")
    fido2 = Shelterdog.create(name: "Fido", breed: "Appenzell Mountain Dog",
                           shelter: "Shamrock", age: "young",
                           weight: "M", status: "A")
    shell_output = ""
    IO.popen('./fetchdog --environment test', 'r+') do |pipe|
      pipe.puts("1")
      pipe.puts("2")
      pipe.puts("1")
      pipe.puts("2")
      pipe.puts("1")
      pipe.puts("4")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Here are Australian Terriers in the surrounding area:\n#{fido1.id}. Fido"
  end
end