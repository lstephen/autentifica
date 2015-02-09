{-# Language OverloadedStrings #-}

module Autentifica.User (userSite) where

import Control.Applicative
import Control.Monad

import Data.Aeson
import Data.ByteString.Char8 as BS

import Snap.Core
import Snap.Http.Server

userSite :: MonadSnap m => m ()
userSite = method POST $ ifTop create

create :: MonadSnap m => m ()
create = do
  body <- readRequestBody maxBound
  case (decode body :: Maybe Create) of
    Nothing -> modifyResponse $ setResponseCode 400
    Just c  -> do
        req <- getRequest
        modifyResponse $ setHeader "Location" (location req) 
        writeJSON user
      where
        user = User $ uid c
        location req = BS.concat ["http://", rqServerName req, ":", (BS.pack . show . rqServerPort) req, rqContextPath req, (BS.pack . uid) c]

data Create = Create { uid :: String, pwd :: String }

instance FromJSON Create where
  parseJSON (Object o) = Create <$> o .: "id" <*> o .: "password"
  parseJSON _          = mzero


data User = User String

instance ToJSON User where
  toJSON (User uid) = object [ "id" .= uid ]

writeJSON :: (MonadSnap m, ToJSON j) => j -> m ()
writeJSON = writeLBS . encode


