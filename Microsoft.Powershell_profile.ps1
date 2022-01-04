# TODO: Categorise stuff like aliases to their own files

# Import all scripts
$scriptfolder = "$env:USERPROFILE\Documents\Powershell\Scripts"
$scripts = Get-ChildItem -Path $scriptfolder -Recurse -Include *.psm1
foreach ($file in $scripts) {
    Import-Module $file.FullName
}

# List all modules installed via `Install-Module` and load them.
$modules = Get-ChildItem -Path "$env:USERPROFILE\Documents\Powershell\Modules"
ForEach($file in $modules){
    _perf_timer_start $file.Name
    $file.Name | Import-Module
    _perf_timer_stop $file.Name
}

# Start registering plugins
PlugBegin;
    Plug 'oh-my-posh'
    Plug 'posh-git'
    Plug 'Posh-SSH'
    Plug 'UpdateInstalledModule'
    Plug 'git-aliases'
PlugEnd;

# Install all registered plugins
PlugInstall;

# Set my mastrous Dotfiles Powershell theme
Set-PoshPrompt $env:USERPROFILE\Documents\Powershell\Misc\dotfiles.omp.json

# Set up some custom keyhandlers for PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Replace Powershell's stupid Set-Location alias with something more useful
Remove-Alias -Name sl -Force
New-Alias -Name 'sl' -Value 'ls' -Scope Global

$env:Path += ";$env:USERPROFILE\bin"
