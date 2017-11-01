{-# LANGUAGE DeriveGeneric #-}

module Data.HWDict.Entry where

import Prelude(Show, Eq, String)
import Data.Binary (Binary)
import GHC.Generics (Generic)

type Word = String

type Meaning = String

data Entry =
    Entry Word
          Meaning
    deriving (Show, Eq, Generic)

instance Binary Entry
