Setup.Package
{
    vendor = "liflg.org",
    id = "theocracy",               -- unique identifier, will be proposed as installdirectory SAMPLE: "fakk2"
    description = "Theocracy",      -- full name of the game, will be used during setup SAMPLE: "Heavy Metal: FAKK2"
    version = "1.0-multilanguage_x86",          -- version of the game SAMPLE: "1.02-english"
    splash = "splash.png", -- name of the splash file which has to be placed inside the meta directory
    superuser = false, 
    write_manifest = true, -- needs to be true if an uninstall-option should be provided
                           -- NOTE: atm installing serveral thousands files will slow down the installation process
    support_uninstall = true, 

    postinstall = function(table)
        MojoSetup.platform.runscript("data/update_mvos.cfg.sh", false, MojoSetup.destination)
    end,

    recommended_destinations =
    {
        "/usr/local/games",
	    "/opt/",
    	MojoSetup.info.homedir,
    }, 

    Setup.Readme
    {
        description = "README",
        source = "README.liflg"
    },

    Setup.Media
    {
        id = "theocracy-cd1",          -- unique identifier for the cd/dvd-rom SAMPLE: "fakk2-cd"
        description = "Theocracy CD1", -- this string will be shown to the end-user SAMPLE: "FAKK2-Loki CDROM"
        uniquefile = "tdat.pck"   -- unique file to decide if a disc is the right one SAMPLE: "fakk/pak0.pk3"
    },
    
    Setup.Media
    {
        id = "theocracy-cd2",          -- unique identifier for the cd/dvd-rom SAMPLE: "fakk2-cd"
        description = "Theocracy CD2", -- this string will be shown to the end-user SAMPLE: "FAKK2-Loki CDROM"
        uniquefile = "movie/scenario/briefing1.mpg"   -- unique file to decide if a disc is the right one SAMPLE: "fakk/pak0.pk3"
    },

    Setup.DesktopMenuItem
    {
        disabled = false,
        name = "Theocracy",           -- name of the menu-entry. SAMPLE: "Heavy Metal: FAKK2"
        genericname = "Real-time strategy",    -- generic name. SAMPLE: "Ego-Shooter"
        tooltip = "play Theocracy",        -- tooltip SAMPLE "play Heavy Metal: FAKK2"
        builtin_icon = false,
        icon = "icon.xpm",   -- path to icon file, realtive to the base-dir of the installation
        commandline = "%0/theocracy.sh",    -- gamebinary or startscript, "%0/" stands for the base directory of the installation SAMPLE: "%0/fakk2.sh"
        category = "Game", 
    },

    Setup.OptionGroup -- contains one or more Setup.Option children (only one of them can be selected at the same time)
    {
        description = "Language",

    	Setup.Option
	    {
		    value = true, -- selected by default
    		bytes = 0,
    		description = "English",

        	Setup.File
        	{
	        	wildcards = { "mvos.cfg_english" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
	    },

    	Setup.Option
    	{
    		bytes = 0,
    		description = "French",

            Setup.File
        	{
	        	wildcards = { "mvos.cfg_french" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
    	},

    	Setup.Option
    	{
	    	bytes = 0,
		    description = "German",

            Setup.File
        	{
	        	wildcards = { "mvos.cfg_german" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
    	},

    	Setup.Option
    	{
    		bytes = 0,
    		description = "Italian",

            Setup.File
        	{
	        	wildcards = { "mvos.cfg_italian" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
    	},

	    Setup.Option
    	{
	    	bytes = 0,
    		description = "Magyar",

            Setup.File
        	{
	        	wildcards = { "mvos.cfg_magyar" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
	    },

    	Setup.Option
	    {
		    bytes = 0,
    		description = "Spanish",

            Setup.File
        	{
	        	wildcards = { "mvos.cfg_spanish" },
	        	filter = function(dest)
		    	    return "mvos.cfg"
          		end
    	    },
	    },
    },
 
   Setup.Option
    {    
    	value = true,
    	required = true,   -- user will not be asked about this option, will be installed always
    	disabled = false,
    	bytes = 545412585, -- size of the files, used only(?) for progressbar, Mojosetup does not check available space 
    	description = "Required game data",
    	tooltip = "Needs the Theocracy CDROMs",
   
    	Setup.File                                                            -- no source = "xy" means installing from the "data"-dir of the installer
    	{
	    	wildcards = { "icon.xpm", "README.liflg", "theocracy", "theoserver", "mvos.cfg" },   -- installs file1 and the complete dir1 from the "data"-dir of the installer
	    	filter = function(dest)
   			    if dest == "theocracy" or dest == "theoserver"  then -- sets permission "0755" for every file that has "game-binary" in its name
   				    return dest, "0755"
    			end
			    return dest
  		    end
    	},

    	Setup.File
    	{
    		source = "media://theocracy-cd1/linux/",            -- sets the source to another value SAMPLE: "media://cd-id/", "base:///patch-1.1.tar"
    		wildcards = { "lib*", "theocracy.real", "server" }, -- copies every *.pk3 and *.cfg file from the "fakk"-directory
		    filter = function(dest)
			    if dest == "server" then
                	return "server.real", "0755"   -- make sure it's executable.
            	end
			    if string.sub(dest, string.len(dest) - string.len(".so.0.9") + 1) == ".so.0.9" then
			        return string.sub(dest, 1, string.len(dest) - string.len(".0.9")), "0755"
                end
    			if string.sub(dest, string.len(dest) - string.len(".so.1.0") + 1) == ".so.1.0" then
			        return string.sub(dest, 1, string.len(dest) - string.len(".1.0")), "0755"
			    end
                return dest, "0755"   -- make sure it's executable.
        	end
    	},

    	Setup.File
    	{
    		source = "media://theocracy-cd1/tdat.pck",        -- sets the source to another value SAMPLE: "media://cd-id/", "base:///patch-1.1.tar"
    	},

        Setup.File
    	{
    		source = "media://theocracy-cd2/",                -- sets the source to another value SAMPLE: "media://cd-id/", "base:///patch-1.1.tar"
    		wildcards = { "cd.key", "movie/*", "ReadMe.txt" } -- copies every *.pk3 and *.cfg file from the "fakk"-directory
    	},
    },
}

