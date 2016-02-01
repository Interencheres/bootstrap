# Bootstrap labels repo

## Requirements
  * ruby & gem
  * bundler (install : gem install bundler)

## Install
```bash
bundle install
```

## Configuration
Copy ```config.rb.sample``` to ```config.rb``` and fill the constant, especially the ```ACCESS_TOKEN```.
In order to do so, go to your _settings_ > _Personal access tokens_ and click on the "generate new token" button. After
completing your password, you only need to limit the access to ```repo``` to generate the token.

_NOTE_: remove the token afterwards.

## Run
```bash
bundle exec ruby copy.rb src_repo dst_repo
```

Example :
```bash
bundle exec ruby copy.rb interencheres/bootstrap basti1dr/imwatchingyou
```

# Commit message guidelines

Taken from Angular.

## Commit Message Format
Each commit message consists of a **header**, a **body** and a **footer**.  The header has a special
format that includes a **type**, a **scope** and a **subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```
The header is mandatory and the scope of the header is optional.

Any line of the commit message cannot be longer 100 characters! This allows the message to be easier to read on GitHub as well as in various git tools.

### Type
Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **doc**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing
  semi-colons, etc)
* **refactor**: A code change that neither fixes a bug or adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such as documentation
  generation

### Scope
The scope could be anything specifying place of the commit change.

### Subject
The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end
