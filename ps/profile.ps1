# Define a search function to search Google with a keyword

# Set an alias for VS Code Insiders
Set-Alias code code-insiders

# Setup PSDotFiles
$DotFilesPath = "$env:USERPROFILE\dotfiles"

Function search {
    param (
        [string]$query
    )
    $encodedQuery = [System.Net.WebUtility]::UrlEncode($query)
    Start-Process "https://winget.run/search?query=$encodedQuery"
}

# Generate ssh key
Function ssh-key {
    
    # Ask to enter email
    $email = Read-Host "Enter your email"
    ssh-keygen -t ed25519 -C $email
}