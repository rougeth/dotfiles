import XMonad
import XMonad.Actions.DwmPromote (dwmpromote)
import XMonad.Config.Gnome (gnomeConfig)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Named (named)
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet    as W
import qualified Data.Map           as M
import System.IO

-------------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules
--
myTerminal = "/usr/bin/gnome-terminal"

-------------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:web", "2:dev"] ++ map show [3..8] ++ ["9:full"]

-------------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing a new
-- window. You can use this to, for example, always float a particular
-- program, or have a client always appear on a particular workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To mach on the WM_NAME, you can use 'title' in the same way that 'className'
-- and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Firefox" --> doShift "1:web"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

-------------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values. If
-- you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new defaults,
-- as xmonad preserves your old layout settings by default.
--
-- The available layouts. Note that each layout is separated by |||, which
-- denotes layout choice.
--
basicLayout = Tall nmaster delta ratio where
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2

tallLayout          = named "tall" $ avoidStruts $ basicLayout
wideLayout          = named "wide" $ avoidStruts $ Mirror basicLayout
singleLayout        = named "single" $ avoidStruts $ noBorders Full
fullscreenLayout    = named "fullscreen" $ noBorders Full

myLayoutHook = smartBorders $ fullscreen $ normal
    where
        normal  = tallLayout ||| wideLayout ||| singleLayout
        fullscreen = onWorkspace "9:full" fullscreenLayout

-------------------------3------------------------------------------------------
-- Colors and borders
-- Currently based on the tomorrow night palette.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#282a2e"

-- Color of current window title in xmobar.
xmobarTitleColor = "#81a2be"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#81a2be"

-- Width of the window border in pixels.
myBorderWidth = 1

-------------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default is
-- mod1Mask ("left alt"). You may also consider using mod3Mask ("right alt"),
-- which does not conflict with emacs keybindings. The "windows key" is
-- usually mod4Mask.
--
myModMask = mod4Mask -- Windows/Command key

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    ---------------------------------------------------------------------------
    -- Custom key bindings
    --
    [ ((modMask, xK_KP_Enter), dwmpromote)
    , ((modMask .|. controlMask, xK_m), spawn "amixer set -D pulse Master toggle")
    , ((modMask .|. controlMask, xK_j), spawn "amixer set -D pulse Master 5%-")
    , ((modMask .|. controlMask, xK_k), spawn "amixer set -D pulse Master 5%+")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set -D pulse Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set -D pulse Master 5%+")
    ]

-------------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if you focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-------------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted width
-- mod-q. Used by, e.g., XMonad.Layout.PerWorkspace to initialize per-workspace
-- layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

-------------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
    xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmobarrc"
    xmonad $ defaults {
        logHook = dynamicLogWithPP $ xmobarPP {
              ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
            , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
            , ppSep = "   "
        }
        , manageHook = manageDocks <+> myManageHook
        , startupHook = setWMName "LG3D"
    }

-------------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, everriding fields in
-- the default config. Any you don't override, will use the defaults defined in
-- xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
    -- simple stuff
    terminal                = myTerminal
    , focusFollowsMouse     = myFocusFollowsMouse
    , borderWidth           = myBorderWidth
    , modMask               = myModMask
    , workspaces            = myWorkspaces
    , normalBorderColor     = myNormalBorderColor
    , focusedBorderColor    = myFocusedBorderColor

    -- key bindings
    , keys = myKeys <+> keys defaultConfig
    -- mouseBindings = myMouseBindings

    -- hooks, layouts
    , layoutHook            = myLayoutHook
    , manageHook            = myManageHook
    , startupHook           = myStartupHook
}
