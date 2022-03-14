# TekNorm

> Another Epitech coding-style checker :p

## Table of contents

* __[How to use TekNorm?](#how-to-use-teknorm)__
* __[Features](#features)__
  * [C](#c)
* __[TO-DO](#to-do)__
* __[Bugs](#bugs)__
  * [Known issues](#known-issues)
  * [Reporting bugs](#reporting-bugs)
* __[Getting involved](#getting-involved)__
  * [Share](#share)
  * [Contribute](#contribute)
  * [Contributors](#contributors)

---

## How to use TekNorm?

1. Install TekNorm:
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Thibb1/TekNorm/main/install.sh)"
    ```
2. Run TekNorm:
    ```sh
    teknorm
    ```
3. TekNorm will get analyze your current project files and warn you on code style issues.
4. You can also run TekNorm on a specific files:
    ```sh
    teknorm <file_path>
    ```

## Features

Coding Style Checker for `.c` and `.h` files.

### C

__Major__ | Minor

- [x] O1: __Contents of the delivery folder__
- [x] O2: File extension
- [x] O3: __File coherence (Too many functions in a file > 5)__
- [x] O4: __Naming files and folders (snake_case)__
- [x] G1: __Epitech header__
- [x] G2: __Function separation__
- [x] G3: Indentation of preprocessor directives
- [x] G4: Global variable
- [x] G6: __Include directive__
- [x] G7: Line endings
- [x] G8: Trailing whitespaces
- [x] G9: Leading or trailing blank lines
- [x] F2: __Function name (snake_case)__
- [x] F3: __Number of columns (> 80)__
- [x] F4: __Number of lines (> 20)__
- [x] F5: __Number of arguments (> 4 | void)__
- [x] F6: Comments inside a function
- [x] F7: __Nested functions__
- [x] L1: __Code line content (one statement per line...)__
- [x] L2: Indentation (only check if multiple of 4)
- [x] L3: Spaces
- [x] L4: Curly brackets
- [x] L5: Variable declaration (One variable per line)
- [x] L6: Line jumps
- [x] V1: __Naming identifiers (snake_case && typedef \_t && macro in UPPER_CASE)__
- [x] V3: Pointers
- [x] C1: Conditional branching (depth > 2 && else if branching)
- [x] C2: Ternary (nested && program flow)
- [x] C3: Goto
- [x] A3: Line break at the end of file


## TO-DO

- [x] Auto-update on launch
- [x] Add options
- [x] Check for banned functions
- [ ] Test on Fedora

## Bugs

### Known issues

 - TekNorm doesn't support Haskell yet.
 - Rule G4 may trigger false positives.
 - The project isn't fully tested, so please report any bug you find.

## Reporting bugs

If you find a bug, please report it in the [issue tracker](https://github.com/Thibb1/TekNorm/issues).


## Getting involved

### Share

 - Do you like TekNorm? Please leave [a star](http://github.com/Thibb1/TekNorm/stargazers) on GitHub!
 - You can also share this project to your friends!

### Contribute

Do you have a suggestion or a bug to fix? Please follow theses steps:
  1. Fork [TekNorm](https://github.com/Thibb1/TekNorm/network/members)
  2. Commit and push your changes to the forked repository
  3. Open a [pull request](https://github.com/Thibb1/TekNorm/pulls) and wait :)

### Contributors

Thanks to [all contributors](https://github.com/Thibb1/TekNorm/graphs/contributors)!
