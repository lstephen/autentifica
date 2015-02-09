{-# Language OverloadedStrings #-}

module Main (main) where

import Autentifica.User

import Control.Applicative
import Control.Monad

import Data.Aeson

import Data.ByteString.Char8 as BS

import Snap.Core
import Snap.Http.Server

main = httpServe config site

site = dir "user" userSite

config = setVerbose True . setErrorLog log $ setAccessLog log defaultConfig
  where
    log = ConfigIoLog BS.putStrLn




