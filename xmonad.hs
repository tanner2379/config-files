import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Ungrab
import System.IO

main = do
  xmonad $ defaultConfig
    { terminal = "alacritty"
    } `additionalKeys`
    [ ((shiftMask, xK_Print), ungrab *> spawn "scrot -s -e 'mv $f ~/Pictures/Screenshots/'")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/Screenshots/'")
    , ("M-f", spawn "firefox")
    , ("M-t", spawn terminal)
    , ("M-g", spawn "gmrun")
    , ((mod4Mask, xK_Left), spawn "amixer set Master 5%-")
    , ((mod4Mask, xK_Right), spawn "amixer set Master 5%+")

    ]
