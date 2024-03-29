{-# LANGUAGE TemplateHaskell #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
--   handler monad.
--
module Application where

------------------------------------------------------------------------------
import Data.Lens.Template
import Data.Time.Clock
import Snap.Snaplet
import Snap.Snaplet.Auth
import Snap.Snaplet.Heist
import Snap.Snaplet.Session

------------------------------------------------------------------------------
data App = App
    { _heist :: Snaplet (Heist App)
    , _startTime :: UTCTime
    , _sess :: Snaplet SessionManager
    , _auth :: Snaplet (AuthManager App)
    }

makeLens ''App

instance HasHeist App where
    heistLens = subSnaplet heist


------------------------------------------------------------------------------
type AppHandler = Handler App App


