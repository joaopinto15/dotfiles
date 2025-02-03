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

## 🤖 Metadata 

The `metadata` folder contains XML files that define the configuration and behavior of each component. Below is an explanation of the sample XML structure:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Component xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="Metadata.xsd">
    <FriendlyName></FriendlyName>
    <BasePath></BasePath>
    <Detection>
        <Method></Method>
        <MatchRegEx>false</MatchRegEx>
        <MatchCase>false</MatchCase>
        <MatchPattern></MatchPattern>
        <FindInPath></FindInPath>
        <PathExists></PathExists>
        <Availability></Availability>
    </Detection>
    <InstallPath>
        <SpecialFolder></SpecialFolder>
        <Destination></Destination>
        <HideSymlinks>false</HideSymlinks>
    </InstallPath>
    <IgnorePaths>
        <IgnorePath></IgnorePath>
    </IgnorePaths>
    <AdditionalPaths>
        <AdditionalPath source="">
            <TargetPath symlink="" />
        </AdditionalPath>
    </AdditionalPaths>
    <RenamePaths>
        <RenamePath source="" symlink="" />
    </RenamePaths>
</Component>
```

### Explanation:

- **FriendlyName**: An optional friendly name for the component.
- **BasePath**: Optional path relative to the component directory to use as the source path.
- **Detection**: Configuration to customize component detection.
  - **Method**: Specifies the method used to detect the availability of the component.
  - **MatchRegEx**: Selects either wildcard (default) or regular expression matching.
  - **MatchCase**: Selects either case insensitive (default) or case sensitive matching.
  - **MatchPattern**: The pattern used for matching against the list of retrieved programs.
  - **FindInPath**: Name of the binary to search for in the system's PATH.
  - **PathExists**: Absolute path to test the existence of.
  - **Availability**: Availability state to always return for this component.
- **InstallPath**: Configuration to customize component installation path.
  - **SpecialFolder**: Specifies a special folder from the Environment.SpecialFolder enumeration.
  - **Destination**: Specifies an absolute or relative destination path subject to SpecialFolder.
  - **HideSymlinks**: Specifies whether component symlinks should be hidden.
- **IgnorePaths**: Configuration of relative paths which should be ignored.
  - **IgnorePath**: Each relative path to ignore should be placed in an IgnorePath element.
- **AdditionalPaths**: Configuration of relative source paths which should have additional symlinks created under a different path.
  - **AdditionalPath**: Specifies the source and target paths for additional symlinks.
- **RenamePaths**: Configuration of relative source paths which should have their target symlink created under a different path.
  - **RenamePath**: Specifies the source and target paths for renamed symlinks.

The `metadata` folder should contain XML files like the one above for each component you want to manage with PSDotFiles.
for a full detailed explanation check the [sample.xml](sample.xml) file.
