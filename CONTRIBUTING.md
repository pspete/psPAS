# Contributing

All contributions, whether comments, code or otherwise are welcomed and appreciated.

## psPAS Issues

If you find an error in `psPAS`, or have a question relating to the module, [log an issue][new-issue].

## Contributing Code

- Fork the repo.
- Push your changes to your fork.
- Write [good commit messages][commit]
- Submit a pull request to the [Dev Branch][dev-branch]
  - Keep pull requests limited to a single issue
  - Discussion, or necessary changes may be needed before merging the contribution.

### PowerShell Styleguide

Use the standard *Verb*-*Noun* convention, and only use approved verbs.

All Functions must have Comment Based Help.

[K&R (One True Brace Style variant)](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81) preferred.

### Pull Requests

When submitting a Pull Request to psPAS, automated tasks will run in Appveyor.

- Appveyor will increment the version number (there is no need to do this manually)
- The [`Pester`][pester-repo] tests for the module will run.
- [Code Coverage][code-coverage] metrics for the module will be determined
- If the PR is accepted into the `master` branch, and all tests pass, the module is automatically published to the PowerShell Gallery.

[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[OTBS]: https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81
[new-issue]: https://github.com/pspete/psPAS/issues/new
[dev-branch]: https://github.com/pspete/psPAS/tree/dev
[pester-repo]: https://github.com/pester/Pester
[code-coverage]: https://coveralls.io/github/pspete/psPAS