{-# LANGUAGE DeriveGeneric #-}

module Data.HWDict.Entry where

import Prelude(Show, Eq, String)
import Data.Binary (Binary)
import GHC.Generics (Generic)
import Data.Text (Text)

type Word = Text

type Meaning = Text

data Entry =
    Entry Word
          Meaning
    deriving (Show, Eq, Generic)

instance Binary Entry
