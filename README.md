# dog_breed_app

Dog Breed app with BloC state management in Flutter.

## Errors
-The BloC provider's _mapFilterDogBreedsToState for filtering the dog breeds and its state management causes the error "index out of the range" since it tries to filter both image url's and breed names at the same time.
-The BloC provider to get the operating system information causes a "Bad state" error when the bottom sheet opens for the second time.

## Bugs
-The images tried to be fetched during the splash screen and they have to be cached but again they can be still in the loading position when the home screen appears.

## Missing parts
-The API can be misused because the generate button has to generate random dog images related to the current breed but both the breed images and randomly generated images are the same it uses the same API call.

