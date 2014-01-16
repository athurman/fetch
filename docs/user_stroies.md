User Stories - fetch
=====

## Survey User for Top 5 Dog Breed List ##
```
As a soon-to-be dog owner
I want to know which dog is the best for my lifestyle
In order to rescue the right dog for me from a shelter or adoption center.

Usage: ./fetchdog

Acceptance Criteria:
* User will be asked a series of yes/no / multiple choice questions
  (similar to git add -p format)
* Prints out a list of the top 5 dog breeds that best fit user lifestyle,
  as well as the least 5 dog breeds that fit user lifestyle
* Will be asked zipcode, can opt out at this point if user so chooses
* Based on results of the top 5 dog breeds and the location of the user,
  the application prints out 5 - 10 shelters that house dog breeds that are similar
  to the results of the survey
* If no results are found, user will be asked if they would like to search somewhere else
```

## Select Shelter to View Shelter Stats ##
```
As a soon-to-be dog owner
I want to know information about certain shelters
In order to know I am adopting a dog from a shelter with good stats

Usage: ./fetchshelter "[zipcode]"

Acceptance Criteria:
* Application prints out a list of shelters in the surrounding area
* If no shelters are found, user will be prompted to select another area
* User selects a shelter from the list
* Application prints out shelter stats
  - Adoption rate
  - Current number of dogs within shelter
  - Dog breed most seen within that shelter
  - Average dog age
  - Average time a dog stays in that shelter
```

## Create a Dog ##
```
Usage: ./fetchdog create "Breed Name" "Size" "Life Span" "Weight" "Height" "Group" "Special Needs"

Acceptance Criteria:
* Creates a new record of a dog, using each string as a piece of information
* 5 arguments are required
```

## Update Dog ##
```
Usage: ./fetchdog update "Breed"

Acceptance Criteria:
* Finds dog by breed name and lists breed information
* Prompts user to select the piece of info they would like to update
* User inputs the information they would like to update
* Dog breed profile updates
```

## Delete Dog ##
```
Usage: ./fetchdog delete "Breed"

Acceptance Criteria:
* Finds dog by breed name
* If no breed is found lists names of breeds similar to the input
* Deletes dog from database
```