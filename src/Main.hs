{-# Language OverloadedStrings #-}

module Main (main) where

import Control.Applicative
import Control.Monad

import Data.Aeson

import Data.ByteString.Char8 as BS

import Snap.Core
import Snap.Http.Server

main = httpServe config site

site = dir "user" user

config = setVerbose True $ setErrorLog (ConfigIoLog BS.putStrLn) $ setAccessLog (ConfigIoLog BS.putStrLn) defaultConfig

user = method POST $ ifTop createUser


createUser = do
  body <- readRequestBody maxBound
  case (decode body :: Maybe UserCreate) of
    Nothing -> modifyResponse $ setResponseCode 400
    Just v -> modifyResponse $ setHeader "Location" ""


data UserCreate = UserCreate { uid :: String, pwd :: String }

instance FromJSON UserCreate where
  parseJSON (Object o) = UserCreate <$> o .: "id" <*> o .: "password"
  parseJSON _          = mzero



