#!/bin/bash
CFG="$PWD/linux_setup/config"

# apt-get
sudo apt-get update
sudo apt-get install -y zsh vim tmux wget curl git htop nvtop cmake

# download directory
git clone https://github.com/donnydonny123/linux_setup $HOME/linux_setup

# bashrc
echo "Copying bashrc"
cp -f $CFG/.bashrc $HOME/.bashrc
source $HOME/.bashrc

# zsh & oh-my-zsh
sudo chsh -s /bin/zsh $USER
# git clone https://github.com/robbyrussell/oh-my-zsh.git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
## extension
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zshrc
echo "Copying zshrc"
cp -f $CFG/.zshrc $HOME/.zshrc
source $HOME/.zshrc

# vim
echo "Copying vimrc"
cp -f $CFG/.vimrc $HOME/.vimrc
source $HOME/.vimrc

# gitconfig
echo "Copying gitconfig"
cp -f $CFG/.gitconfig $HOME/.gitconfig

# tmux
echo "Copying tmux.conf"
cp -f $CFG/.tmux.conf $HOME/.tmux.conf
source $HOME/.tmux.conf

## install miniconda python
while true; do
    read -p "Do you want to install Miniconda3? (Y/N) " yn
    case $yn in
        [Yy])
            # install Anaconda3
            fileName=`curl -sS https://docs.conda.io/en/latest/miniconda.html | grep -Po 'Miniconda3-latest-Linux(.*?)x86_64\.sh'`
            curl -fsSL https://repo.anaconda.com/miniconda/$fileName > /tmp/miniconda.sh
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