import System.IO
import XMonad
import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Ungrab

import XMonad.Hooks.ManageHelpers (isDialog, doFullFloat, doCenterFloat)

import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.Column
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS
import XMonad.Actions.WorkspaceNames


-- visibleWorkspaces :: X [WorkspaceId]
-- visibleWorkspaces = do
--   ws <- gets windowset
--   return $ map (W.tag . W.workspace) $ W.current ws : W.visible ws

-- joinToString :: [String] -> String
-- joinToString workspaceIds = foldl (++) "" workspaceIds

-- screenString = joinToString $ map (W.tag . W.workspace) $ visibleScreens $ W.windowSet
-- screenString = map getWorkspaceName visibleWorkspaces

myManageHook::ManageHook
myManageHook = composeAll
  [ className =? "Gimp" --> doCenterFloat
  , className =? "gmrun" --> doCenterFloat
  , className =? "Widentify" --> doFloat
  , isDialog --> doFloat
  ]

myLayout = smartBorders (ResizableTall 1 (3/100) (1/2) [] ||| Grid ||| Column 1.8)

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "~/.screenlayout/default.sh &"
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
    [ ((shiftMask, xK_Print), unGrab *> spawn "scrot -s -e 'mv $f ~/Pictures/screenshots/'")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/screenshots/'")
    , ((mod4Mask, xK_Left), spawn "amixer set Master 5%-")
    , ((mod4Mask, xK_Right), spawn "amixer set Master 5%+")
    , ((mod4Mask, xK_Up), spawn "lux -a 10%")
    , ((mod4Mask, xK_Down), spawn "lux -s 10%")
    , ((mod1Mask .|. shiftMask, xK_l), sendMessage MirrorShrink)
    , ((mod1Mask .|. shiftMask, xK_h), sendMessage MirrorExpand)
    , ((mod1Mask, xK_f), spawn "firefox")
    , ((mod1Mask, xK_a), spawn myTerminal)
    , ((mod1Mask, xK_g), spawn "gmrun")
    , ((mod1Mask, xK_Tab), moveTo Next NonEmptyWS)
    , ((mod1Mask .|. shiftMask, xK_Tab), shiftTo Next EmptyWS)
    , ((mod4Mask, xK_l), spawn "env XSECURELOCK_LIST_VIDEOS_COMMAND='find ~/Screensavers -type f' XSECURELOCK_SAVER=saver_mpv XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 XSECURELOCK_IMAGE_DURATION_SECONDS=300 XSECURELOCK_PASSWORD_PROMPT=time xsecurelock")
    -- , ((mod4Mask, xK_v), spawn $ "widentify " ++ screenString)

    ]
