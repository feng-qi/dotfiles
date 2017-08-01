-- For xmonad-0.8 and greater
import           XMonad
import           XMonad.Config.Kde
import qualified XMonad.StackSet   as W

main = xmonad kdeConfig
       { modMask = mod4Mask            -- use the Windows button as mod
       , manageHook = manageHook kdeConfig <+> myManageHook
       }
myManageHook = composeAll . concat $
               [ [ className =? c --> doFloat           | c <- myFloats]
               , [ title     =? t --> doFloat           | t <- myOtherFloats]
               , [ className =? c --> doF (W.shift "2") | c <- webApps]
               , [ className =? c --> doF (W.shift "3") | c <- ircApps]
               ]
  where myFloats      = ["MPlayer", "Gimp"]
        myOtherFloats = ["alsamixer"]
        webApps       = ["Firefox"]
        ircApps       = ["Ksirc"]

-- xmonad-0.7 and earlier
-- import           XMonad
-- import           XMonad.Hooks.EwmhDesktops
-- import           XMonad.Hooks.ManageDocks
-- import qualified XMonad.StackSet           as W

-- main = xmonad defaultConfig
--     { manageHook            = manageHook defaultConfig <+> myManageHook
--     , logHook               = ewmhDesktopsLogHook
--     , layoutHook            = avoidStruts $ layoutHook defaultConfig
--     , modMask               = mod4Mask -- use the Windows button as mod
--     }

-- myManageHook = manageDocks <+> composeAll . concat $
--      [ [ className   =? c --> doFloat           | c <- myFloats]
--      , [ title       =? t --> doFloat           | t <- myOtherFloats]
--      , [ className   =? c --> doF (W.shift "2") | c <- webApps]
--      , [ className   =? c --> doF (W.shift "3") | c <- ircApps]
--      ]
--   where
--     myFloats      = ["MPlayer", "Gimp"]
--     myOtherFloats = ["alsamixer"]
--     webApps       = ["Firefox-bin", "Opera"] -- open on desktop 2
--     ircApps       = ["Ksirc"]                -- open on desktop 3
