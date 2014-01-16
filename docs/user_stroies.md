User Stories - fetch
=====

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