import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Actions.GridSelect
import XMonad.Actions.GroupNavigation

import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)

------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"
myBrowser       = "firefox"
myEmacs         = "emacs"


------------------------------------------------------------------------
-- Workspaces
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
------------------------------------------------------------------------
-- Window rules
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
myManageHook = composeAll
    [ className =? "Mozilla Firefox" --> doShift "3"
    , className =? "Google-chrome"   --> doShift "2:web"
    , className =? "skype"           --> doShift "3:im"
    , className =? "Icedove"         --> doShift "3:mail"
    , resource  =? "desktop_window"  --> doIgnore
    , className =? "Galculator"      --> doFloat
    , className =? "Steam"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , resource  =? "gpicview"        --> doFloat
    , className =? "MPlayer"         --> doFloat
    , className =? "Xchat"           --> doShift "3:im"
    , className =? "stalonetray"     --> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]


------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (witterminatorterminatorh 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    noBorders (fullscreenFull Full))


------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
myNormalBorderColor  = "black"
myFocusedBorderColor = "#777777"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

-- Color of current window title in xmobar.
  -- Used to be #00CC00
xmobarTitleColor = "#d9d9d9"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- Width of the window border in pixels.
myBorderWidth = 2


colorOrange         = "#FD971F"
colorDarkGray       = "#1B1D1E"
colorPink           = "#F92672"
colorGreen          = "#A6E22E"
colorBlue           = "#66D9EF"
colorYellow         = "#E6DB74"
colorWhite          = "#CCCCC6"

colorNormalBorder   = "#CCCCC6"
colorFocusedBorder  = "#fd971f"


------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $



  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask .|. shiftMask, xK_Return),
     spawn $ XMonad.terminal conf)

  -- [ On / Off ] Network
  , ((modMask .|. shiftMask, xK_o),
     spawn "nmcli networking off")
  , ((modMask, xK_o),
     spawn "nmcli networking on")

 -- launch dmenu
  , ((modMask, xK_p),
     spawn "dmenu_run")

  -- launch browser
  , ((modMask,xK_b),
     spawn (myBrowser))

  -- launch Emacs
  , ((modMask, xK_x),
     spawn (myEmacs))

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Close focused window.
  , ((modMask, xK_w),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- -- Move focus to the next window.
  -- , ((modMask, xK_Tab),
  --    windows W.focusDown)

-- use Alt+Tab and Alt+Shift+Tab to change focus to different windows across workspaces
  , ((modMask, xK_Tab), nextMatch Forward isOnAnyVisibleWS)
  , ((modMask .|. shiftMask, xK_Tab), nextMatch Backward isOnAnyVisibleWS)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)
  
  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Toggle the status bar gap.
  -- TODO: update this binding with avoidStruts, ((modMask, xK_b),

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

  ]


------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()


------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad $ docks defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "    "
      }
      , manageHook = manageDocks <+> myManageHook
      , startupHook = setWMName "LG3D"
  }


------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
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
    layoutHook         = smartBorders $ myLayout,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
}



-- -- The preferred terminal program, which is used in a binding below and by
-- -- certain contrib modules.
-- --
-- myTerminal      = "alacritty"
-- myBrowser       = "firefox"
-- myEmacs         = "emacs"

-- -- Whether focus follows the mouse pointer.
-- myFocusFollowsMouse :: Bool
-- myFocusFollowsMouse = True

-- -- Whether clicking on a window to focus also passes the click to the window
-- myClickJustFocuses :: Bool
-- myClickJustFocuses = False

-- -- Width of the window border in pixels.
-- --
-- myBorderWidth   = 2

-- -- modMask lets you specify which modkey you want to use. The default
-- -- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- -- ("right alt"), which does not conflict with emacs keybindings. The
-- -- "windows key" is usually mod4Mask.
-- --
-- myModMask       = mod4Mask

-- -- The default number of workspaces (virtual screens) and their names.
-- -- By default we use numeric strings, but any string may be used as a
-- -- workspace name. The number of workspaces is determined by the length
-- -- of this list.
-- --
-- -- A tagging example:
-- --
-- -- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- -- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
-- -- myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

-- -- clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
-- --     where i = fromJust $ M.lookup ws myWorkspaceIndices

-- -- Border colors for unfocused and focused windows, respectively.
-- --
-- myNormalBorderColor  = "#000000"
-- myFocusedBorderColor = "#666666"

-- ------------------------------------------------------------------------
-- -- Key bindings. Add, modify or remove key bindings here.
-- --
-- myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

--     -- launch a terminal
--     [ ((modm .|. shiftMask, xK_Return), spawn (myTerminal))

--     -- launch browser
--     , ((modm,               xK_b     ), spawn (myBrowser))

--     -- launch Emacs
--     , ((modm,               xK_x     ), spawn (myEmacs))

--     -- launch dmenu
--     , ((modm,               xK_p     ), spawn "dmenu_run")

--     -- launch gmrun
--     , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

--     -- close focused window
--     , ((modm .|. shiftMask, xK_c     ), kill)

--      -- Rotate through the available layout algorithms
--     , ((modm,               xK_space ), sendMessage NextLayout)

--     --  Reset the layouts on the current workspace to default
--     , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

--     -- Resize viewed windows to the correct size
--     , ((modm,               xK_n     ), refresh)

--     -- Move focus to the next window
--     , ((modm,               xK_Tab   ), windows W.focusDown)

--     -- Move focus to the next window
--     , ((modm,               xK_j     ), windows W.focusDown)

--     -- Move focus to the previous window
--     , ((modm,               xK_k     ), windows W.focusUp  )

--     -- Move focus to the master window
--     , ((modm,               xK_m     ), windows W.focusMaster  )

--     -- Swap the focused window and the master window
--     , ((modm,               xK_Return), windows W.swapMaster)

--     -- Swap the focused window with the next window
--     , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

--     -- Swap the focused window with the previous window
--     , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

--     -- Shrink the master area
--     , ((modm,               xK_h     ), sendMessage Shrink)

--     -- Expand the master area
--     , ((modm,               xK_l     ), sendMessage Expand)

--     -- Push window back into tiling
--     , ((modm,               xK_t     ), withFocused $ windows . W.sink)

--     -- Increment the number of windows in the master area
--     , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

--     -- Deincrement the number of windows in the master area
--     , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

--     -- Toggle the status bar gap
--     -- Use this binding with avoidStruts from Hooks.ManageDocks.
--     -- See also the statusBar function from Hooks.DynamicLog.
--     --
--     -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

--     -- Quit xmonad
--     , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

--     -- Restart xmonad
--     , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

--     -- Run xmessage with a summary of the default keybindings (useful for beginners)
--     , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
--     ]
--     ++

--     --
--     -- mod-[1..9], Switch to workspace N
--     -- mod-shift-[1..9], Move client to workspace N
--     --
--     [((m .|. modm, k), windows $ f i)
--         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--     ++

--     --
--     -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
--     -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
--     --
--     [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
--         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
--         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-- ------------------------------------------------------------------------
-- -- Mouse bindings: default actions bound to mouse events
-- --
-- myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

--     -- mod-button1, Set the window to floating mode and move by dragging
--     [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
--                                        >> windows W.shiftMaster))

--     -- mod-button2, Raise the window to the top of the stack
--     , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

--     -- mod-button3, Set the window to floating mode and resize by dragging
--     , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
--                                        >> windows W.shiftMaster))

--     -- you may also bind events to the mouse scroll wheel (button4 and button5)
--     ]

-- ------------------------------------------------------------------------
-- -- Layouts:

-- -- You can specify and transform your layouts by modifying these values.
-- -- If you change layout bindings be sure to use 'mod-shift-space' after
-- -- restarting (with 'mod-q') to reset your layout state to the new
-- -- defaults, as xmonad preserves your old layout settings by default.
-- --
-- -- The available layouts.  Note that each layout is separated by |||,
-- -- which denotes layout choice.
-- --
-- myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
--   where
--      -- default tiling algorithm partitions the screen into two panes
--      tiled   = Tall nmaster delta ratio

--      -- The default number of windows in the master pane
--      nmaster = 1

--      -- Default proportion of screen occupied by master pane
--      ratio   = 1/2

--      -- Percent of screen to increment by when resizing panes
--      delta   = 3/100

-- ------------------------------------------------------------------------
-- -- Window rules:

-- -- Execute arbitrary actions and WindowSet manipulations when managing
-- -- a new window. You can use this to, for example, always float a
-- -- particular program, or have a client always appear on a particular
-- -- workspace.
-- --
-- -- To find the property name associated with a program, use
-- -- > xprop | grep WM_CLASS
-- -- and click on the client you're interested in.
-- --
-- -- To match on the WM_NAME, you can use 'title' in the same way that
-- -- 'className' and 'resource' are used below.
-- --
-- myManageHook = composeAll
--     [ className =? "MPlayer"        --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "desktop_window" --> doIgnore
--     , resource  =? "kdesktop"       --> doIgnore ]

-- ------------------------------------------------------------------------
-- -- Event handling

-- -- * EwmhDesktops users should change this to ewmhDesktopsEventHook
-- --
-- -- Defines a custom handler function for X Events. The function should
-- -- return (All True) if the default handler is to be run afterwards. To
-- -- combine event hooks use mappend or mconcat from Data.Monoid.
-- --
-- myEventHook = mempty

-- ------------------------------------------------------------------------
-- -- Status bars and logging

-- -- Perform an arbitrary action on each internal state change or X event.
-- -- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- --
-- myLogHook = return ()

-- ------------------------------------------------------------------------
-- -- Startup hook

-- -- Perform an arbitrary action each time xmonad starts or is restarted
-- -- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- -- per-workspace layout choices.
-- --
-- -- By default, do nothing.
-- myStartupHook = return ()

-- ------------------------------------------------------------------------
-- -- Now run xmonad with all the defaults we set up.

-- -- Run xmonad with the settings you specify. No need to modify this.
-- --
-- main = do
--   xmproc <- spawnPipe "xmobar -x 1 /home/ssap/.config/xmobar/xmobar.config"
--   xmonad $ docks defaults

-- -- A structure containing your configuration settings, overriding
-- -- fields in the default config. Any you don't override, will
-- -- use the defaults defined in xmonad/XMonad/Config.hs
-- --
-- -- No need to modify this.
-- --
-- defaults = def {
--       -- simple stuff
--         terminal           = myTerminal,
--         focusFollowsMouse  = myFocusFollowsMouse,
--         clickJustFocuses   = myClickJustFocuses,
--         borderWidth        = myBorderWidth,
--         modMask            = myModMask,
--         workspaces         = myWorkspaces,
--         normalBorderColor  = myNormalBorderColor,
--         focusedBorderColor = myFocusedBorderColor,

--       -- key bindings
--         keys               = myKeys,
--         mouseBindings      = myMouseBindings,

--       -- hooks, layouts
--         layoutHook         = myLayout,
--         manageHook         = myManageHook,
--         handleEventHook    = myEventHook,
--         logHook            = myLogHook,
--         startupHook        = myStartupHook
--     }

-- -- | Finally, a copy of the default bindings in simple textual tabular format.
-- help :: String
-- help = unlines ["The default modifier key is 'alt'. Default keybindings:",
--     "",
--     "-- launching and killing programs",
--     "mod-Shift-Enter  Launch xterminal",
--     "mod-p            Launch dmenu",
--     "mod-Shift-p      Launch gmrun",
--     "mod-Shift-c      Close/kill the focused window",
--     "mod-Space        Rotate through the available layout algorithms",
--     "mod-Shift-Space  Reset the layouts on the current workSpace to default",
--     "mod-n            Resize/refresh viewed windows to the correct size",
--     "",
--     "-- move focus up or down the window stack",
--     "mod-Tab        Move focus to the next window",
--     "mod-Shift-Tab  Move focus to the previous window",
--     "mod-j          Move focus to the next window",
--     "mod-k          Move focus to the previous window",
--     "mod-m          Move focus to the master window",
--     "",
--     "-- modifying the window order",
--     "mod-Return   Swap the focused window and the master window",
--     "mod-Shift-j  Swap the focused window with the next window",
--     "mod-Shift-k  Swap the focused window with the previous window",
--     "",
--     "-- resizing the master/slave ratio",
--     "mod-h  Shrink the master area",
--     "mod-l  Expand the master area",
--     "",
--     "-- floating layer support",
--     "mod-t  Push window back into tiling; unfloat and re-tile it",
--     "",
--     "-- increase or decrease number of windows in the master area",
--     "mod-comma  (mod-,)   Increment the number of windows in the master area",
--     "mod-period (mod-.)   Deincrement the number of windows in the master area",
--     "",
--     "-- quit, or restart",
--     "mod-Shift-q  Quit xmonad",
--     "mod-q        Restart xmonad",
--     "mod-[1..9]   Switch to workSpace N",
--     "",
--     "-- Workspaces & screens",
--     "mod-Shift-[1..9]   Move client to workspace N",
--     "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
--     "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
--     "",
--     "-- Mouse bindings: default actions bound to mouse events",
--     "mod-button1  Set the window to floating mode and move by dragging",
--     "mod-button2  Raise the window to the top of the stack",
--     "mod-button3  Set the window to floating mode and resize by dragging"]
