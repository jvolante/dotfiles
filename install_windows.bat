echo "Setting up Vim"
copy _vimrc %HOMEPATH%
robocopy /e /MT vimfiles %HOMEPATH%\vimfiles
echo "Done with vim"
