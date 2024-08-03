#!/bin/bash
CFG="$HOME/linux_setup/config"
# apt-get
apt-get install -y sudo
sudo apt-get update
sudo apt-get install -y zsh vim tmux wget curl git htop cmake fzf

# download directory
if [ ! -d "$HOME/linux_setup" ]; then
    git clone https://github.com/donnydonny123/linux_setup $HOME/linux_setup
fi

# bashrc
echo "Copying bashrc"
cp -f $CFG/.bashrc $HOME/.bashrc
source $HOME/.bashrc

# zsh & oh-my-zsh
sudo chsh -s /bin/zsh $USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --keep-zshrc --unattended
## extension
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# zshrc
echo "Copying zshrc"
if [ -f "$HOME/.zshrc" ]; then
    mv $HOME/.zshrc $HOME/.zshrc.bak
fi
cp -f $CFG/.zshrc $HOME/.zshrc
sed -i "s|{pwd}|$HOME|g" $HOME/.zshrc
source $HOME/.zshrc

# vim
if [ ! -f "$HOME/.vimrc" ]; then
    echo "Copying vimrc"
    cp -f $CFG/.vimrc $HOME/.vimrc
fi

# gitconfig
if [ ! -f "$HOME/.gitconfig" ]; then
    echo "Copying gitconfig"
    cp -f $CFG/.gitconfig $HOME/.gitconfig
fi

# tmux
if [ ! -f "$HOME/.tmux.conf" ]; then
    echo "Copying tmux.conf"
    ln -s $CFG/.tmux.conf $HOME/.tmux.conf
    tmux source-file $HOME/.tmux.conf
fi

## install miniconda python if running with an terminal
while test -t 0 && [ -z "${INSTALL_PYTHON}" ] ; do
    read -p "Do you want to install Miniconda3? (Y/N) " INSTALL_PYTHON
    case $INSTALL_PYTHON in
        [Yy])
            # install Anaconda3
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
            bash /tmp/miniconda.sh
            rm /tmp/miniconda.sh
            break
            ;;
        [Nn])
            break
            ;;
        *)
            echo "Please answer Y or N."
    esac
done