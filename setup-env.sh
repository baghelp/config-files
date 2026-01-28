#!/bin/bash

# === Install NVM if not installed ===
#
#
# Only install Node on non-Pi machines
if ! uname -m | grep -q 'aarch64'; then
  if [ ! -d "$HOME/.nvm" ]; then
    echo -e "\n\nInstalling NVM...\n--------------\n"
    export NVM_DIR="$HOME/.nvm"
    mkdir -p "$NVM_DIR"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source "$NVM_DIR/nvm.sh"
    nvm install --lts
  else
    echo -e "\n\nNVM already installed\n--------------\n"
  fi
else
  echo -e "\n\nSkipping NVM (Pi detected)...\n--------------\n"
fi


# === Install Neovim via apt (may not be latest version) ===
if ! command -v nvim >/dev/null 2>&1; then
  echo "\n\nInstalling Neovim via apt...\n--------------\n"
  sudo apt update
  sudo apt install -y neovim
else
  echo "\n\nNeovim already installed.\n--------------\n"
fi

# === Make 'vim' command point to 'nvim' ===
if ! command -v vim >/dev/null 2>&1 || ! readlink -f "$(command -v vim)" | grep -q 'nvim'; then
  echo "\n\nBinding 'vim' command to Neovim...\n--------------\n"
  sudo ln -sf "$(command -v nvim)" /usr/local/bin/vim
  sudo ln -sf "$(command -v nvim)" /usr/bin/vim
else
  echo "\n\n'vim' already points to Neovim.\n--------------\n"
fi

# === Link ~/.vimrc to Neovim config ===
echo -e "\n\nLinking ~/.vimrc to Neovim config...\n--------------\n"
mkdir -p "$HOME/.config/nvim"
if [ ! -L "$HOME/.config/nvim/init.vim" ]; then
  ln -sf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
  echo -e "\n\nLinked ~/.vimrc → ~/.config/nvim/init.vim\n--------------\n"
else
  echo -e "\n\ninit.vim already linked.\n--------------\n"
fi

# === Install vim-plug for Neovim ===
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  echo -e "\n\nInstalling vim-plug...\n--------------\n"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo -e "\n\nvim-plug already installed.\n--------------\n"
fi
