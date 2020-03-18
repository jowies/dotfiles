local path = "/home/jowie/.config/awesome/icons/"

local applications = {
	{ 
	  path_to_active = path ... "firefox.svg",
	  path_to_inactive = path .. "firefox-grey.svg",
	  command = "firefox",
	  instance = "Navigator",
	},
	{ 
	  path_to_active = path ... "terminal.svg",
	  path_to_inactive = path .. "terminal-grey.svg",
	  command = "kitty",
	  instance = "kitty",
	},
	{ 
	  path_to_active = path ... "file-manager.svg",
	  path_to_inactive = path .. "file-manager-grey.svg",
	  command = "pcmanfm",
	  instance = "pcmanfm",
	},
	{ 
	  path_to_active = path ... "spotify.svg",
	  path_to_inactive = path .. "spotify-grey.svg",
	  command = "spotify",
	  instance = "spotify",
	},
	{ 
	  path_to_active = path ... "slack.svg",
	  path_to_inactive = path .. "slack-grey.svg",
	  command = "slack",
	  instance = "slack",
	},
	{ 
	  path_to_active = path ... "visual-studio-code.svg",
	  path_to_inactive = path .. "visual-studio-code-grey.svg",
	  command = "code-oss",
	  instance = "code - oss",
	},
	{ 
	  path_to_active = path ... "web-discord.svg",
	  path_to_inactive = path .. "web-discord-grey.svg",
	  command = "discord",
	  instance = "discord",
	},
	{ 
	  path_to_active = path ... "android-studio.svg",
	  path_to_inactive = path .. "android-studio-grey.svg",
	  command = "android-studio",
	  instance = "sun-awt-X11-XFramePeer",
	},
	{ 
	  path_to_active = path ... "steam.svg",
	  path_to_inactive = path .. "steam-grey.svg",
	  command = "steam",
	  instance = "steam",
	},
	{ 
	  path_to_active = path ... "gimp.svg",
	  path_to_inactive = path .. "gimp-grey.svg",
	  command = "gimp",
	  instance = "gimp",
	},
	{ 
	  path_to_active = path ... "inkscape.svg",
	  path_to_inactive = path .. "inkscape-grey.svg",
	  command = "inkscape",
	  instance = "inkscape",
	},
}
return applications
