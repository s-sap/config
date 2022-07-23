-- Setup for dual 1920x1080 monitors
Config {
    position = Static { xpos = 0 , ypos = 0, width = 1920, height = 15 },
    borderColor = "#000000",
    font = "xft:Source Code Pro Bold:size=11",
    bgColor = "#000000",
    fgColor = "#707070",
    lowerOnStart = True,

    commands = [ Run Memory         [ "--template" ,"Mem: <usedratio>%"
                  , "--Low"      , "20"        -- units: %
                  , "--High"     , "90"        -- units: %
                  , "--low"      , "darkgreen"
                  , "--normal"   , "darkorange"
                  , "--high"     , "darkred"
                  ] 10
               
               , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10          
               , Run DiskU [("/home", "hdd: <free>")] [] 60
	       , Run Uptime ["Up: <hours>h"] 360
               , Run StdinReader
               , Run Date           "   %m-%d-%Y || %a  <fc=#ABABAB> [  %H:%M:%S ]</fc>" "date" 10

               ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %dynnetwork%   |  %disku%  |  %memory%  |  %uptime%    %date%"
}
