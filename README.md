# hwdict

**HWDict** is a program in Haskell that allows you to parse (simple)wiktionary xml dumps to get a dictionary.
You can use it as a command-line tool and a Haskell library.

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

You can get the latest simplewiktionary dump [here](https://dumps.wikimedia.org/backup-index.html).

Look for `simplewiktionary` link on the page and download `simplewiktionary-YYYYMMDD-pages-articles.xml.bz2` file there.

## Example

- Download `simplewiktionary-YYYYMMDD-pages-articles.xml.bz2` file as described above
- Extract xml dump from the archive:
```bash
bzip2 -d simplewiktionary-YYYMMDD-pages-articles.xml.bz2
```
- Convert xml dump to Haskell binary dump with **hwdict** cli:
```bash
hwdict -i simplewiktionary-YYYMMDD-pages-articles.xml -o dict.bin
```
- You can now deserialize `dict.bin` file with Haskell's [binary](https://hackage.haskell.org/package/binary) library and use it in your code.

See `Data.HWDict.Entry` module for types and `Binary` instance:
```haskell
type Word = String
type Meaning = String

data Entry =
    Entry Word Meaning
    deriving (Show, Eq, Generic)
```

## Build
You can build **hwdict** with [stack](https://www.haskellstack.org/):
```bash
$ git clone https://github.com/23ua/hwdict
$ cd hwdict
$ stack build
$ stack install
```
