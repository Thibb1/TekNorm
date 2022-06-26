# TekNorm

## How to use TekNorm?

1. Install TekNorm:
    ```sh
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Thibb1/TekNorm/main/install.sh)"
    ```
2. Run TekNorm:
    ```sh
    teknorm [-bcuh]
    ```
3. TekNorm will analyze your current project files and warn you on code style issues.
4. You can also run TekNorm on a specific files:
    ```sh
    teknorm <file_path>
    ```

## Features

Coding Style Checker for `.c` and `.h` files.


### C

> __Major__ | Minor

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

## Bugs

### Known issues

 - TekNorm doesn't support Haskell yet.
 - Rule G4 may trigger false positives.
 - The project isn't fully tested, so please report any bug you find.
