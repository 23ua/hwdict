{-# LANGUAGE OverloadedStrings #-}

module Data.HWDict
    ( decode
    ) where

-- import Control.Applicative ((<$>), (<*>), liftA2)
-- import Data.List (isPrefixOf)
-- import Data.Maybe (fromMaybe, mapMaybe, listToMaybe)
-- import Data.Monoid (All(All, getAll))
import Data.HWDict.Entry
import Text.XML
import Text.XML.Cursor
import Data.Text (Text)
import qualified Data.ByteString.Lazy as BSL

type Dict = [Entry]

decode :: BSL.ByteString -> Dict
decode xml =
    let doc = parseLBS_ def xml
        cursor = fromDocument doc
--         pages = (cursor $/ element (name "page"))
        titles = cursor $/ element (name "page") &/ element (name "title") &/ content
        meanings = cursor $/ element (name "page") &/ element (name "revision") &/ element (name "text") &/ content
    in zipWith Entry titles meanings

name :: Text -> Name
name localName =
    Name localName (Just "http://www.mediawiki.org/xml/export-0.10/") Nothing

--         wordPages = filterWords <$> listToMaybe (onlyElems contents)
--     in mapMaybe pageToEntry <$> wordPages

-- filterWords :: Element -> [Element]
-- filterWords = filterChildren $ isPage <&&> notServicePage
--   where
--     isPage = (qName' "page" ==) . elName
--     notServicePage e =
--         getAll . mconcat $ map (All . notPageStartsWith e) servicePrefixes
--     notPageStartsWith e prefix =
--         not $ fromMaybe False $ (prefix `isPrefixOf`) <$> findTitle e
--
-- servicePrefixes :: [String]
-- servicePrefixes =
--     [ "MediaWiki:"
--     , "Wiktionary:"
--     , "Template:"
--     , "Help:"
--     , "Category:"
--     , "File:"
--     , "Appendix:"
--     , "Module:"
--     , "Main Page"
--     ]
--
-- pageToEntry :: Element -> Maybe Entry
-- pageToEntry e = Entry <$> findTitle e <*> findMeaning e
--
-- findTitle :: Element -> Maybe String
-- findTitle e = strContent <$> findElementByName "title" e
--
-- findMeaning :: Element -> Maybe String
-- findMeaning e =
--     strContent <$> (findElementByName "text" =<< findElementByName "revision" e)
--
-- findElementByName :: String -> Element -> Maybe Element
-- findElementByName str = findElement (qName' str)
--
-- qName' :: String -> QName
-- qName' str =
--     QName
--     { qName = str
--     , qURI = Just "http://www.mediawiki.org/xml/export-0.10/"
--     , qPrefix = Nothing
--     }

-- (<&&>) :: (a -> Bool) -> (a -> Bool) -> a -> Bool
-- (<&&>) = liftA2 (&&)
