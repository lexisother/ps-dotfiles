# So, after approximately less than a day of work, I present to you... My DIY
# plugin manager for PowerShell! So... why? Well, `Install-Module` sucks. It's
# presented as "the package manager of PowerShell", but in reality, it's just a
# tool for installing modules. Nothing more, nothing less. So, I wrote my own.
# It is, at the time of writing, minimal, but I expect that to change soon. The
# codebase is nicely commented, so it should be readable.

# Initialize a hashtable for storing plugins
$plugins = @{}

# TODO: Add a way to specify a directory to install plugins to
# Function thatstarts the plugin registration sequence by giving
# the user access to the `Plug` function.
function PlugBegin {
    function Global:Plug {
    param (
        $plugin
    )
        $plugins.$plugin = $plugin
    }
}

# Get rid of the `Plug` function, the user shouldn't use it anymore
function PlugEnd {
    Remove-Item -Path Function:Plug
}

# Return the array of plugins, perhaps useful for something like `PlugUpdate` later on
function PlugGet {
    return $plugins
}

# Install whatever isn't installed yet from the hashtable
function PlugInstall {
    $modulefolder = "$env:USERPROFILE\Documents\Powershell\Modules"
    $modules = Get-ChildItem -Path $modulefolder
    foreach ($plugin in $plugins.GetEnumerator()) {
        if ($plugin.Name -in $modules.Name) {
            return
        }
        else {
            Write-Host "Installing plugin $($plugin.Name)..."
            Install-Module $plugin.Name -Force
        }
    }
}