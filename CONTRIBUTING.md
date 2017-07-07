# Contributing

All contributions welcomed and are appreciated.

## Module Conventions
### PowerShell Styleguide
Use the standard *Verb*-*Noun* convention, and only use approved verbs.
All Functions must have Comment Based Help.

###Module Structure
Any functions which expose documented functionality of the API must exist in the folder under the [Functions](Functions/) directory relevant to the functional area (user, group, safe etc.) of the function (which is based on the structure of the official CyberArk documentation).
Any helper functions, consumed by other functions of the module must exist in the [Private](Private/) directory.

## Contributing Code

 - Fork the repo.
 - Push your changes to your fork. 
 - Write a [good commit message][commit]
 - Submit a pull request
	 - Keep pull requests limited to a single issue
	 - Discussion, or necessary changes may be needed before merging the contribution.

[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html