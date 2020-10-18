# Transpiler-JS Action

## Package Managers

## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/JossyDevers/transpiler-js/blob/master/LICENSE) 

## Version
[![GitHub Release](https://img.shields.io/github/v/release/jossydevers/transpiler-js)]()

Github action to transpile javascript code to make it cross-browser compatible, using [@babel/cli](https://babeljs.io/docs/en/babel-cli), [@babel/core](https://www.npmjs.com/package/@babel/core) and [@babel/preset-env](https://babeljs.io/docs/en/babel-preset-env) packages.

### Usage
Here the target branch is `master`. You need to checkout your repository so the ES2015 Trasnpiler job can access it. Then, you can auto-commit the files to the repository if desired.

```yaml
name: Transpiler-JS Workflow
on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # Checks-out your repository
      - uses: actions/checkout@v2
        with:
          ref: ${{ github.ref }}
          
      # Job for transpiler the code
      - name: 'Transpiler-JS Action'
        uses: jossydevers/transpiler-js@v1.0.0
        with:
          # If the typename is specified, the transpilation result file will be as follows path/filename.{tipename}.js
          # By default the value is 'release'
          typename: 'release' (OPTIONAL)
          # Directory in which to start searching for files to transpile
          # By default the entire repository is transpiled
          directory: 'src/' (OPTIONAL)
          # Directory where the transpilation result will be stored
          # By default each transpiled file is saved in the folder next to the original file
          output: 'transpile/' (OPTIONAL)
          
      # Auto-commit to repository
      - uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: Github Action : Code Transpiled
          branch: ${{ github.ref }}
```
