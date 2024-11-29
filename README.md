# 🌟 DotFiles Repository

This repository contains my dotfiles for configuring a personalized Linux environment. Using **GNU Stow**, you can easily manage and symlink dotfiles to your home directory. 

---

## 🚀 Features
- Organized dotfiles for different tools and environments.
- Easy management using **GNU Stow**.
- Compatible with any Linux distribution.

---

## 📥 Installation

### 1. Clone the Repository
First, clone this repository to your home directory or a directory of your choice:
```bash
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
```

---

### 2. Install **GNU Stow**
#### For Debian/Ubuntu:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install stow -y
```

#### For Arch Linux/Manjaro:
```bash
sudo pacman -Syu
sudo pacman -S stow
```

---

### 3. Link Dotfiles
To link the dotfiles to your home directory, run the following command inside the repository:
```bash
stow *
```

This will symlink the directories (e.g., `vim`, `zsh`, `git`, etc.) to the corresponding locations in your home directory.

---

## 🛠️ Usage Tips
- Organize your dotfiles into subdirectories (e.g., `vim`, `zsh`, `git`).
- To link a specific configuration only, specify its directory:
  ```bash
  stow vim
  ```
- To remove a symlinked configuration:
  ```bash
  stow -D vim
  ```
- To remove all symlinked configurations created from this repository:
  ```bash
  stow -D *
  ```

---

## 📜 Notes
1. Ensure you back up your existing configuration files before linking new ones.
2. Adjust subdirectory names in the repository to match your configuration needs.

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