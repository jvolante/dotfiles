echo "Setting up Vim"
cp _vimrc ~/.vimrc
cp -r vimfiles ~/.vim
vim +PlugInstall +qall
echo "Done with Vim"
