import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
	, focusFollowsMouse = False
	, clickJustFocuses = False
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        } `additionalKeys`
	[ ((0, 0x1008ff13),
	    spawn "amixer -D pulse set Master 3%+ unmute")
	, ((0, 0x1008ff11),
	    spawn "amixer -D pulse set Master 5%- unmute")
	, ((0, 0x1008ff12),
	    spawn "amixer -D pulse set Master mute")
	, ((0, 0x1008ff02),
	    spawn "xbacklight -inc 5")
	, ((0, 0x1008ff03),
	    spawn "xbacklight -dec 5")
	, ((0, 0xffeb),
	    spawn "eject -T")

	-- Audio previous
	, ((0, 0x1008ff16),
	    spawn "")
	
	-- Play/Pause
	, ((0, 0x1008ff14),
	    spawn "")

	-- Audio next
	, ((0, 0x1008ff17),
	    spawn "")
	]
 







