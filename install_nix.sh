echo "Setting up Vim"
ln -s _vimrc ~/.vimrc
ln -s vimfiles ~/.vim
vim +silent! +PlugInstall +qall
echo "Done with Vim"
echo "Setting up Xonsh"
ln -s _xonshrc ~/.xonshrc
echo "Done with Xonsh"
