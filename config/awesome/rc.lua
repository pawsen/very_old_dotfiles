-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--require("vicious")
-- Til dropdown. Hentet fra awesome wiki
require("scratch")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
--terminal = "termintor"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
local altkey = "Mod1"
local home   = os.getenv("HOME")
local exec  = function(cmd) awful.util.spawn(cmd, false) end
local sexec = awful.util.spawn_with_shell
local scount = screen.count() -- bruges fx ved 'for s=1,scount do
--exec        = awful.util.spawn
--zenburn theme virker desværre ikke ordentlig
--beautiful.init(home .. "/.config/awesome/zenburn.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {  
   awful.layout.suit.floating,
   awful.layout.suit.tile,
   awful.layout.suit.tile.bottom, -- 2
   awful.layout.suit.fair,        -- 3
   awful.layout.suit.max,         -- 4
   awful.layout.suit.magnifier,   -- 5
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "logout", awesome.quit }
}

-- {{{ Build the individual app lists first
app_tools = {
    { "search", "catfish" },
--    { "archive", "file-roller" },
--    { "text", "gedit" },
--    { "term", "terminator" },
    { "file", "thunar" },
    { '<span color="red">file</span>', "gksudo thunar" }}
--    { "calc", "gcalctool" } }
 app_web = {
--    { "midori", "midori" },
--    { "chrome", "google-chrome" },
--    { "uzbl", "uzbl-tabbed" },
--    { "gFTP", "gftp" },
    { "torrent", "transmission" }}
--    { "irc", "xchat" },
--    { "chat", "gajim" },
--    { "heybuddy", "heybuddy" } }

 app_img = {}
--    { "gimp", "gimp" },
--    { "view", "viewnior" },
--    { "color", "gcolor2" } }
 app_media = {
 { "smPlayer", "smplayer"}}
--    { "decibel", "decibel-audio-player" },
--    { "pithos", "pithos" },
--    { "pogo", "pogo" },
 --   { "rip", "asunder" },
 --  { "mix", "xfce4-mixer" } }
app_work = {
--    { "abiword", "abiword" },
--    { "gnumeric", "gnumeric" },
 --   { "gummi", "gummi" }, 
    { "libreoffice", "libreoffice" } }
apps_menu = {
    { "tools", app_tools },
    { "web", app_web },
    { "img", app_img },
    { "media", app_media },
    { "work", app_work } }
--same thing with settings
set_term = {
    { "man", 'terminator --command="man terminator"' },
    { "config", 'gedit ~/.config/terminator/config' } }
set_display = {
    { "grandr", "grandr" },
    { "xrandr", "xrandr" },
    { "man xrandr", 'terminator --command="man xrandr"' } }
set_system = {
    { "printing", "gksudo system-config-printer" },
    { "gparted", "gksudo gparted" },
    { "gdm", "gksudo gdmsetup" },
    { "synaptic", "gksudo synaptic" } }
settings_menu = {
    { "term", set_term },
    { "display", set_display },
    { "defaults", 'terminator --command="sudo update-alternatives --all"' },
    { "gtk", "lxappearance" },
    { "screensaver", "xscreensaver-demo" },
    { "system", set_system } }
--and the end stuff
screenshots = {
 --  { "Now", "scrot '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f /home/case/images/screenshots/$f'" },
 --  { "Wait 5s", "scrot -d 5 '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f /home/case/images/screenshots/$f'" } }
}
help_menu = {
    { "awesome wiki", "midori https://awesome.naquadah.org/wiki/Main_Page" } }


mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "web", "midori" },
                                    { "text", "gedit" },
                                    { "word", "abiword" },
                                    { "zim", "zim" },
                                    { "file", "thunar" },
                                    { "apps", apps_menu },
                                    { "settings", settings_menu },
                                    { "screenshot", screenshots },
                                    { "help", help_menu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,"Control" }, "Left",   awful.tag.viewprev),
    awful.key({ modkey,"Control" }, "Right",  awful.tag.viewnext),
    awful.key({ altkey }, "Tab", awful.tag.history.restore),
    awful.key({ modkey }, "p", function () awful.screen.focus_relative(1) end),
    awful.key({ modkey }, "s", function () scratch.pad.toggle() end),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey }, "j", function ()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "k", function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({ modkey }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end),
    awful.key({ altkey }, "Escape", function ()
        awful.menu.menu_keys.down = { "Down", "Alt_L" }
        local cmenu = awful.menu.clients({width=230}, { keygrabber=true, coords={x=525, y=330} })
    end),
    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1)  end),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    -- }}}

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    -- Dmenu tilføjelse
    awful.key({ modkey },            "r",     function ()
    awful.util.spawn("dmenu_run -i -p 'Run command:' -nb '" .. 
 		beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. 
		"' -sb '" .. beautiful.bg_focus .. 
		"' -sf '" .. beautiful.fg_focus .. "'") 
	end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- tilføjelse
    -- awful.key({ }, "XF86Display", function () exec(terminal) end),
    --awful.key({ }, "#107", function () exec(terminal) end), -- print screen
    awful.key({ }, "#107", function () sexec("xwd | convert - /tmp/screenshot-$(date +%s).png") end), -- print screen
    awful.key({"Shift"}, "#107", function () sexec("xwd -frame | convert - /tmp/screenshot-$(date +%s).png") end), -- print screen
    awful.key({"Control"}, "#107", function () sexec("xwd -root | convert - /tmp/screenshot-$(date +%s).png") end), -- print screen
    awful.key({ modkey }, "e", function () exec("emacsclient -n -c") end),
    awful.key({ modkey }, "w", function () exec("chromium") end),
    awful.key({ modkey }, "F1", function () scratch.drop("urxvt", "top","left",.40,400) end),
--awful.key({ altkey }, "#49", function () scratch.drop("urxvt", "bottom", nil, nil, 0.30) end),
    -- Lyd
    awful.key({ modkey }, "KP_Add", function () sexec("amixer set Master playback 5+") end),
    awful.key({ modkey }, "KP_Subtract", function () sexec("amixer set Master playback 5-") end),
--    awful.key({  }, "F5", function () sexec("auto-disper -c") end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- giver en terminal. Husker histori med pil-op. Lidt som dmenu
    awful.key({ modkey }, "F2", function ()
        awful.prompt.run({ prompt = "Run: " }, mypromptbox[mouse.screen].widget,
            function (...) mypromptbox[mouse.screen].text = exec(unpack(arg), false) end,
            awful.completion.shell, awful.util.getdir("cache") .. "/history")
     end),

    awful.key({ modkey  }, "q", function ()
        awful.prompt.run({ prompt = "Web: " }, mypromptbox[mouse.screen].widget,
            function (command)
                sexec("chromium 'http://yubnub.org/parser/parse?command="..command.."'")
               -- awful.tag.viewonly(tags[scount][3])
            end)
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey }, "d", function (c) scratch.pad.set(c, 0.60, 0.60, true) end),
    awful.key({ modkey }, "Next",  function () awful.client.moveresize( 0,0, 40, 40) end),
    awful.key({ modkey }, "Prior", function () awful.client.moveresize(0, 0,  -40,  -40) end),
--    awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Shift" }, "f", function (c) if awful.client.floating.get(c)
        then awful.client.floating.delete(c);    awful.titlebar.remove(c)
        else awful.client.floating.set(c, true); awful.titlebar.add(c) end
     end),
    awful.key({ modkey, "Shift" }, "t", function (c)
        if   c.titlebar then awful.titlebar.remove(c)
        else awful.titlebar.add(c, { modkey = modkey }) end
    end),

    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- {{{
-- tilføjet for autostart
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
       pname = prg
    end

    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("wicd-client",nil,"/usr/bin/python2 -O /usr/share/wicd/gtk/wicd-client.py")
run_once("devmon","&",nil)
run_once("volti","&",nil)
run_once("xfce4-power-manager","&",nil)
run_once("xfce4-panel","&",nil)
run_once("trayfreq","&",nil)
run_once("rainlendar","&",nil)
run_once("xfsettingsd","&",nil)
run_once("conky","&",nil)
run_once("emacs","--daemon &",nil)
-- }}}
