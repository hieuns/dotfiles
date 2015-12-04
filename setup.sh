#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

for filename in .[a-z]*
do
    if [ -f "$f" ]
    then
        ln -s ${PWD}/$filename ~/
    fi
done

vim +PluginInstall +qall
