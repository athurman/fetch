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
Usage: ./fetchdog add "Name" --breed "Breed Name" --shelter "Shelter Name" --age "Age" --weight "Weight" --status "Status"

Acceptance Criteria:
* Creates a new record of a shelter dog
* prints summary of new dog
* all arguments are required, if one or more argument is missing prints error message
```

## Update Dog ##
```
Usage: ./fetchdog update "Dog Name"

Acceptance Criteria:
* Finds shelter dog by name and lists information
* Prompts user to select the piece of info they would like to update
* User inputs the information they would like to update
* Shelter dog profile updates
```

## Delete Dog ##
```
Usage: ./fetchdog delete "Dog Name"

Acceptance Criteria:
* Finds dog by name
* If no dog is found informs user and asks them to try again
* Deletes dog from database
```