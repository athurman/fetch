Data Planning
=====

#### User
  * ID
  * ZipCode

#### DogType
  * ID
  * BreedName (e.g. "German Shepherd")
  * Size (Small, Medium, Large)
  * Lifespan (e.g. 10 - 15 years)
  * Weight (e.g 65 - 95 lbs.)
  * Height (e.g. 22" - 26")
  * Group (e.g. "Herding") - Seperate Table of Groups?
  * Special Needs (e.g. "Exercise", "Grooming") - Seperate Table of Special Needs?
  * Temperament (e.g. "Smart", "Family-Oriented", "Protective") - Seperate Table of Temperaments?

#### ShelterDog
  * ID
  * DogType ID
  * Shelter ID
  * Name (e.g. "Fido")
  * Age (e.g. 3)
  * Weight (e.g. "78 lbs.")
  * Status (e.g. "Adoptable", "Holding", "Adopted/Removed")

#### Shelter
  * ID
  * Location (e.g Zip Code)
  * ShelterName (e.g. "Humane Society of Nashville")
  * TotalDogs (e.g. 45)
