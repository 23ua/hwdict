module Main where

import Data.HWDict (decode)
import Options.Applicative
import Data.Semigroup ((<>))
import Data.Binary (encodeFile)

newtype PathIn = PathIn FilePath
newtype PathOut = PathOut FilePath

main :: IO ()
main = handle =<< execParser opts
    where
        opts = info (convertParser <**> helper)
            ( fullDesc
            <> progDesc "You can convert xml to haskell binary format"
            <> header "hwdict -- parse wiktionary xml dump to get a dictionary"
            )

handle :: Opts -> IO()
handle (Convert (PathIn inFile) (PathOut outFile)) = do
    xml <- readFile inFile
    let maybeEntries = decode xml
    let numProcessed = show $ maybe 0 length maybeEntries
    mapM_ (encodeFile outFile) maybeEntries
    putStrLn $ numProcessed ++ " words written to " ++ outFile

convertParser :: Parser Opts
convertParser = Convert
    <$> (fmap PathIn <$> strOption)
        ( long "input"
        <> short 'i'
        <> metavar "INPUT_FILE"
        <> help "Read xml from INPUT_FILE"
        )
    <*> (fmap PathOut <$> strOption)
        ( long "output"
        <> short 'o'
        <> metavar "OUTPUT_FILE"
        <> help "Write binary data converted from xml to OUTPUT_FILE"
        )

data Opts =
    Convert PathIn PathOut
