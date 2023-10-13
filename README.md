# Pre-Commit-Hooks-Magento2-b5

These Pre-Commit-Hooks are using the tasks from the taskfiles. These need to be installed/imported/copied in your Magento 2 Project if you do not have them already. Don't forget to source them in your PROJECTDIR/build/Taskfile.

Then create a `.pre-commit-config.yaml` in your project directory (on the same level as your build and web or src directory) with the following content:
```
# See https://pre-commit.com for more information
# See https://pre-commit.com/hooks.html for more hooks
repos:
  - repo: https://github.com/team23/pre-commit-hooks-magento2-b5
    rev: 'v1.0.0'
    hooks:
      - id: php-cs
      - id: php-stan
      - id: php-md
      - id: magento-eslint

```

Once this is set up, the `b5 install` task should install `pre-commit` via brew, if it is not already installed. 

## How does it work?
The pre-commit hook downloads on the first `git commit` a short installation script. This downloads all given hooks from the `.pre-commit-config.yaml` file and stores them into `~/.cache/pre-commit`. After this it executes all hooks on the staged files depending on the file type that is defined for each hook. If you need to update the hooks, create a merge/pull request with the changes and once these are in the main branch, create a new tag. This tag is the `rev:` version within the config file. If something goes wrong and you need to reset your locally installed pre-commit hooks you can just run `pre-commit clean`. This will delete all hooks in your .cache directory. Each hook will run a bash script from the `pre-commit-hooks` directory. (Just to make it clear again: These scripts are written in a way, that uses your b5 commit tasks. If you do not have these tasks yet, just use the sample tasks from the `taskfiles` directory). You can add more hooks by adding it to the `.pre-commit-hooks.yaml` file and adding a correlating script for it. 