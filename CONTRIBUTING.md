# Contributing
Volunteers are welcome to contribute to the Animatify iOS app codebase.
## Branch Policy

There are two branches in this repository-
* **dev**- All new development work goes on in this branch. If you're looking to contribute to the project, you are supposed to make a pull request to *dev*.
* **master**- Once everything works efficiently in the dev branch after incorporating the pull requests, I'll merge the code into the *master* branch.

## Code Styling

  #### Prefer structs over classes
  * Unless you require functionality that can only be provided by a class (like inheritance, deinitializers) I recommend that you always use a struct.
* Structs are easier to manage, and since they are of the value type, it leads to a lesser amount of bugs due to referencing.

#### When specifying a variable always provide the type
 * Providing variables with type improves the code readability.
 * It also reduces the type mismatch error and possible crashes.
#### Creating Extensions for reusable components
* Do create extensions for methods that you'll be using elsewhere in the project.
* It helps in keeping the code clean and maintainable. 

#### Follow the code structuring and organization
* All the codes in this project are organized in separate groups, and you follow the same hierarchy while writing code.
* If you feel that creating a new group is required, do make one.

## Issues
Issues are necessary for any project. They serve a lot of purposes-
 * You can check for new tasks that you can do for contributing to the Hacktoberfest 
 * It's a place to add your suggestions and feature requests.
 * You can also mention bugs and improvements there.

## Pull Requests (PR's)
Pull requests are the way to get your code merged into the repository.
Reviewing code takes time, and it'll efficiently help me if you follow these guidelines while raising a PR-
* State the intention of the pull request, add a clear description of what you've added and changed, whether you solved an existing problem.
* Add a screenshot for UI changes. It'll allow me to give any feedback that I may have, without having to need to check out into your branch.
* Following the guidelines mentioned in the ***Code Styling***.
    
## How will I know that my contribution was accepted?
Your PR will be merged and I'll drop an ending comment,this will mean that your contribution was accepted and merged into the codebase.
I'll also add your name to the Contributor's list. :D
