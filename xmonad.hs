import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Ungrab
import XMonad.Hooks.ManageHelpers (isDialog, doFullFloat, doCenterFloat)
import Graphics.X11.ExtraTypes.XF86
import System.IO

myManageHook::ManageHook
myManageHook = composeAll
  [ className =? "gimp" --> doFullFloat
  , className =? "gmrun" --> doCenterFloat
  , isDialog --> doFloat
  ]

main = do
  xmonad $ defaultConfig
    { terminal = "alacritty"
    , manageHook = myManageHook
    } `additionalKeys`
    [ ((shiftMask, xK_Print), unGrab *> spawn "scrot -s -e 'mv $f ~/Pictures/Screenshots/'")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/Screenshots/'")
    , ((mod4Mask, xK_Left), spawn "amixer set Master 5%-")
    , ((mod4Mask, xK_Right), spawn "amixer set Master 5%+")
    , ((mod4Mask, xK_Up), spawn "lux -a 10%")
    , ((mod4Mask, xK_Down), spawn "lux -s 10%")
    ] `additionalKeysP`
    [ ("M-f", spawn "firefox")
    , ("M-a", spawn "alacritty")
    , ("M-g", spawn "gmrun")
    ]
