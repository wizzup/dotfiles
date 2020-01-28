module Main where

import XMonad
import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Accordion
import XMonad.Layout.Decoration
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import qualified XMonad.StackSet as W

import qualified Data.Map        as M

-- import System.Taffybar.Support.PagerHints (pagerHints)

import System.Exit

-- The preferred terminal program.
myTerminal :: String
-- myTerminal = "alacritty"
-- myTerminal = "urxvt"
-- myTerminal = "termite"
myTerminal = "termite"

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 1

-- "windows key" mod4Mask as a mod-key.
--
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces  = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor :: String
myNormalBorderColor  = "#dddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    , ((modm , xK_b ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    -- , ((modm              , xK_q     ), restart "xmonad" True)

    -- launch dvol volume up
    , ((modm,               xK_Up    ), spawn "exe=`~/.dvol.sh -i 3` && eval \"exec $exe\"")

    -- launch dvol volume down
    , ((modm,               xK_Down  ), spawn "exe=`~/.dvol.sh -d 3` && eval \"exec $exe\"")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig t -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.swapMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout :: ModifiedLayout AvoidStruts (Choose Tall (Choose (ModifiedLayout WithBorder Full) Accordion)) Window
myLayout = avoidStruts (
            Tall 1 (3/100) (1/2) |||
            noBorders Full |||
            Accordion
            )

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
-- tabConfig = defaultTheme {
tabConfig :: Theme
tabConfig = def {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
    }

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- myManageHook = composeAll
--     [ className =? "MPlayer"        --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "desktop_window" --> doIgnore
--     , resource  =? "kdesktop"       --> doIgnore ]
--
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

------------------------------------------------------------------------
-- Status bars and logging
--
-- myLogHook = return ()
myLogHook :: X ()
myLogHook = dynamicLog

------------------------------------------------------------------------
-- Startup hook
-- myStartupHook = return ()

------------------------------------------------------------------------
-- The main function.
main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- main = do
--   c <- statusBar myBar myPP toggleStrutsKey defaults
--   xmonad
--      $ docks
--      $ ewmh
--      $ pagerHints c

-- Command to launch the bar.
myBar :: String
-- myBar = "taffybar"
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP :: PP
-- myPP = def
myPP = xmobarPP

-- Key binding to toggle the gap for the bar.
toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
defaults :: XConfig (ModifiedLayout AvoidStruts (Choose Tall (Choose (ModifiedLayout WithBorder Full) Accordion)))
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        logHook            = myLogHook
        -- manageHook         = myManageHook,
        -- startupHook        = myStartupHook,
    }
