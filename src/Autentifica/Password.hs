{-# LANGUAGE EmptyDataDecls, GADTs, MultiParamTypeClasses, FlexibleInstances #-}

module Autentifica.Password(Password(), toPassword, PlainText, Encrypted, encrypt) where

import Control.Applicative
import Control.Monad
import Control.Monad.IO.Class

import Crypto.PasswordStore

import Data.Aeson
import Data.ByteString
import Data.String

data PlainText
data Encrypted

data Password a where
  PlainText :: ByteString -> Password PlainText
  Encrypted :: ByteString -> Password Encrypted

encrypt :: MonadIO m => Password a -> m (Password Encrypted)
encrypt (Encrypted b) = return $ Encrypted b
encrypt (PlainText b) = liftM Encrypted $ liftIO (makePassword b 17)

class ToPassword a where
  toPassword :: a -> Password PlainText

instance ToPassword ByteString where
  toPassword = PlainText

instance FromJSON (Password PlainText) where
  parseJSON (String s) = mzero
  parseJSON _          = mzero
