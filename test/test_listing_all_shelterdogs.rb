require_relative 'helper'

class TestListingShelterDogs < FetchTest
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
clear
       ,
       |`-.__     ad88                                 88
       / ' _/    d8\"                 ,d                88
      ****`      88                  88                88
     /    }    MM88MMM  ,adPPYba,  MM88MMM  ,adPPYba,  88,dPPYba,
    /  \\ /       88    a8P_____88    88    a8\"     \"\"  88P'    \"8a
\\ /`   \\\\\\       88    8PP\"\"\"\"\"\"\"    88    8b          88       88
 `\\    /_\\\\      88    \"8b,   ,aa    88,   \"8a,   ,aa  88       88
  `~~~~~``~`     88     `\"Ybbd8\"'    \"Y888  `\"Ybbd8\"'  88       88

                                 -- GO FOR IT --

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