{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
--   site. The 'app' function is the initializer that combines everything
--   together and is exported by this module.
--
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Control.Monad.Trans
import           Control.Monad.State
import           Data.ByteString (ByteString)
import           Data.Maybe
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import           Data.Time.Clock
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Heist
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Text.Templating.Heist
import           Text.XmlHtml hiding (render)
------------------------------------------------------------------------------
import           Application


------------------------------------------------------------------------------
-- | Renders the front page of the sample site.
--
-- The 'ifTop' is required to limit this to the top of a route.
-- Otherwise, the way the route table is currently set up, this action
-- would be given every request.
index :: Handler App App ()
index = render "index"
------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/", index),
           ("/register", with auth registerHandler),
           ("/login", with auth loginHandler),
           ("/logout", with auth logoutHandler)
         ]

registerHandler :: Handler App (AuthManager App) ()
registerHandler = do
  l <- getParam "login"
  p <- getParam "password"
  case (l, p) of
    (Nothing, _) -> render "register"
    (_, Nothing) -> render "register"
    (Just _, Just _) -> do
      registerUser "login" "password"
      redirect' "/" 303
          
loginHandler :: Handler App (AuthManager App) ()
loginHandler = do
  l <- getParam "login"
  p <- getParam "password"
  case (l, p) of
    (Nothing, _) -> render "login"
    (_, Nothing) -> render "login"
    (Just _, Just _) -> do
      loginUser "login" "password" Nothing (\_ -> redirect' "/" 303) (redirect' "/" 303)
        
logoutHandler :: Handler App (AuthManager App) ()
logoutHandler = do
  logout
  redirect' "/" 303


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    sTime <- liftIO getCurrentTime
    h <- nestSnaplet "heist" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $ initCookieSessionManager "site_key.txt" "sess" (Just 3600) -- 1 hour login timeout
    a <- nestSnaplet "auth" auth $ initJsonFileAuthManager defAuthSettings sess "users.json"
    addRoutes routes
    addAuthSplices auth
    return $ App h sTime s a
