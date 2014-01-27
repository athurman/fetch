require_relative 'helper'
require_relative '../models/shelterdog'

class TestShelterDog < FetchTest
  def test_to_s_prints_details
    fido = ShelterDog.new(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    expected = "#{fido.id}. Fido:\n  breed: Collie\n  shelter: Humane Society\n  age: young\n  weight: M\n  status: A"
    assert_equal expected, fido.to_s
  end

  def test_saved_purchases_are_saved
    fido = ShelterDog.new(name: "Fido", breed: "Collie",
                          shelter: "Humane Society", age: "young",
                          weight: "M", status: "A")
    fido_before = database.execute("select count(id) from shelterdogs")[0][0]
    fido.save
    fido_after = database.execute("select count(id) from shelterdogs")[0][0]
    assert_equal fido_before + 1, fido_after
  end
end