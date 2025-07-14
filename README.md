
# 🛠️ dotfiles_linux

This repository contains personal configuration files (dotfiles) for Linux development environments. It uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks and keep your `$HOME` directory clean and organized.

## 📦 Structure

Each subdirectory in this repo represents a group of related dotfiles. For example:

```

dotfiles\_linux/
├── git/
│   └── .gitconfig
├── vscode/
│   └── .config/Code/User/settings.json

````

These are meant to be symlinked into your home directory using `stow`.

## 🔧 How to Use

1. **Clone the repo** anywhere on your system:

   ```bash
   git clone https://github.com/yourusername/dotfiles_linux.git
   cd dotfiles_linux
    ```

2. **Preview what will be symlinked** with:

   ```bash
   stow -nv -t ~ git
   ```

   The `-n` flag performs a dry run (no changes made),
   `-v` shows verbose output,
   `-t ~` tells `stow` to link into your home directory.

3. **Apply the symlinks**:

   ```bash
   stow -v -t ~ git
   ```

   Repeat this for other folders like `vscode`:

   ```bash
   stow -v -t ~ vscode
   ```

## 💡 Notes

* Make sure to remove or backup existing dotfiles before stowing if you get conflicts.
* This approach works well for versioning your configs and syncing across machines.

## 📁 Recommended Layout

You can include dotfiles for:

* Git → `git/.gitconfig`
* Bash → `bash/.bashrc`
* VSCode → `vscode/.config/Code/User/settings.json`
* Neovim → `nvim/.config/nvim/init.lua`
* And more...

---

### **System Setup Overview** ✨

#### **Distro**:

* **[Arch Linux](https://www.archlinux.org/)**

#### **Window Manager**:

* **[KDE Plasma](https://kde.org/plasma-desktop/)**

#### **Display Manager**:

* **[LY (LightDM)](https://github.com/nullgemm/ly)**

---

### **Core Applications & Tools** 🛠️

#### **Browser**:

* **[Brave Browser](https://brave.com/)**

#### **Terminal**:

* **[Ghostty](https://ghostty.dev/)**

#### **Code Editor**:

* **[Visual Studio Code](https://code.visualstudio.com/)**
* **[Neovim](https://neovim.io/)**

---

### **Aesthetics** 🎨

#### **Icon Theme**:

* **[WhiteSur-dark](https://github.com/vinceliuice/WhiteSur-gtk-theme)**

#### **Cursor Theme**:

* **[Bibata Classic](https://github.com/ChrisTitusTech/bibata-cursor-theme)**


#### **Wallpaper Clock**:

* **[ModernClock](https://github.com/7thSamurai/ModernClock)**
