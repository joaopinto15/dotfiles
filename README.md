# 🌟 DotFiles Repository

This repository contains my dotfiles for configuring a personalized Windows environment. Using [PSDotFiles](https://github.com/ralish/PSDotFiles), you can easily manage and symlink dotfiles to your home directory. 

---

## 🚀 Features
- Organized dotfiles for different tools and environments.
- Easy management using **PSDotFiles**.
- Compatible with Powershell.

---

## 📥 Installation

### 1. Install PSDotFiles module
```posh
Install-Module -Name PSDotFiles
```

---

### 2. Check if every is good 👍
#### For Debian/Ubuntu:
```posh
Get-Module PSDotFiles -ListAvailable
```
---

### 3. Config
Before you can use PSDotFiles you should set the $DotFilesPath variable to the location of your dotfiles folder. For example:
```posh
$DotFilesPath = "C:\Users\<your.account>\dotfiles"
```

---

## 🛠️ Usage Tips

There are some additional variables you can set in your profile which modify default behaviour:

- `$DotFilesAllowNestedSymlinks` (default: `$false`)  
  Allow directory symlinks to destinations outside of the source component path earlier in the path hierarchy.
- `$DotFilesAutodetect` (default: `$false`)  
  Perform automatic detection for components with no metadata file.
- `$DotFilesGlobalIgnorePaths` (default: `@('.stow-local-ignore')`)  
  Paths to ignore for all components in addition to any explicit `<IgnorePath>` elements in the metadata.
- `$DotFilesSkipMetadataSchemaChecks` (default: `$false`)  
  Skip validating metadata files against the metadata schema. Generally only useful in development.
---

## 📜 Commands

```posh
# Enumerates available dotfiles components
Get-DotFiles

# Installs one or more dotfiles components
Install-DotFiles

# Removes one or more dotfiles components
Remove-DotFiles
```

---

## 💡 Example Directory Structure
Here’s an example of how the repository could be structured:
```
dotfiles/
├── vim/       # Vim configuration files
├── zsh/       # Zsh configuration files
├── git/       # Git configuration files
└── tmux/      # Tmux configuration files
```

---

## 📚 References
- [GNU Stow Manual](https://www.gnu.org/software/stow/)

---
