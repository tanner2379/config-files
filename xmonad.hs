import System.IO
import XMonad
import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Ungrab

import XMonad.Hooks.ManageHelpers (isDialog, doFullFloat, doCenterFloat)

import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid

myManageHook::ManageHook
myManageHook = composeAll
  [ className =? "gimp" --> doFullFloat
  , className =? "gmrun" --> doCenterFloat
  , isDialog --> doFloat
  ]

myLayout = ResizableTall 1 (3/100) (1/2) [] ||| Grid
  

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "~/.fehbg &"
  spawnOnce "xsetroot -cursor_name Left_ptr &"
  spawnOnce "lux -S 10% &"


myTerminal :: String
myTerminal = "alacritty"

main = do
  xmonad $ defaultConfig
    { terminal = myTerminal
    , manageHook = myManageHook
    , layoutHook = myLayout
    , startupHook = myStartupHook
    } `additionalKeys`
    [ ((shiftMask, xK_Print), unGrab *> spawn "scrot -s -e 'mv $f ~/Pictures/Screenshots/'")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/Screenshots/'")
    , ((mod4Mask, xK_Left), spawn "amixer set Master 5%-")
    , ((mod4Mask, xK_Right), spawn "amixer set Master 5%+")
    , ((mod4Mask, xK_Up), spawn "lux -a 10%")
    , ((mod4Mask, xK_Down), spawn "lux -s 10%")
    , ((mod1Mask, xK_b), sendMessage MirrorShrink)
    , ((mod1Mask, xK_u), sendMessage MirrorExpand)
    ] `additionalKeysP`
    [ ("M-f", spawn "firefox")
    , ("M-a", spawn myTerminal)
    , ("M-g", spawn "gmrun")
    ]

