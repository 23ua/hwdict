# hwdict

HWDict is a program in Haskell that allows you to parse wiktionary xml dumps to get a dictionary.
You can use it as a command-line tool or a Haskell library.

## Usage

```bash
hwdict -- parse wiktionary xml dump to get a dictionary

Usage: hwdict (-i|--input INPUT_FILE) (-o|--output OUTPUT_FILE)
  You can convert xml to haskell binary format

Available options:
  -i,--input INPUT_FILE    Read xml from INPUT_FILE
  -o,--output OUTPUT_FILE  Write binary data converted from xml to OUTPUT_FILE
  -h,--help                Show this help text
```
