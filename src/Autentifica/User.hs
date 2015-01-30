{-# Language OverloadedStrings #-}

module Autentifica.User where

import Autentifica.Password

import Control.Applicative
import Control.Monad
import Control.Monad.IO.Class

import Data.Aeson
import Data.Aeson.Types

data UserCreate = UserJson { userId :: String, password :: String }

{-instance ToJSON User where
  toJSON u = object [ "id" .= userId u ]-}

instance FromJSON UserJson where
  parseJSON (Object o) = UserJson <$> o .: "id" <*> o .: "password"
  parseJSON _          = mzero


