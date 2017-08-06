# Contributing

All contributions welcomed and are appreciated.

## Module Conventions
### PowerShell Styleguide
Use the standard *Verb*-*Noun* convention, and only use approved verbs.

All Functions must have Comment Based Help.

[K&R (One True Brace Style variant)](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81) preffered.

### Module Structure
The [Functions](Functions/) directory structure is based on the of the structure official CyberArk WebServices SDK documentation). 
Any code exposing documented methods of the API must exist in the folder relevant to the method area (user, group, safe etc.).

Any helper functions, consumed by other functions of the module must exist in the [Private](Private/) directory.

## Contributing Code

 - Fork the repo.
 - Push your changes to your fork. 
 - Write a [good commit message][commit]
 - Submit a pull request
	 - Keep pull requests limited to a single issue
	 - Discussion, or necessary changes may be needed before merging the contribution.

[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
