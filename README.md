Closer
======

This plugin is for vim users that open a lot of buffers and then need to close many at one time.

When activated, the plugin creates a new buffer that lists each open buffer.  It looks something like this.

    1 index.html
    2 js/jquery.js
    3 README.md

The user can move the cursor to the line representing the buffer they would like to close then press 'x' to close the buffer in the background and remove the line.  The user can continue to press 'x' to close buffers.  The user can exit by pressing 'q' which will close the temporary buffer created by the plugin.

Installing
==========

To install, run the following commands:

    mkdir -p ~/.vim/bundle
    cd ~/.vim/bundle
    git clone git://github.com/cskeeters/closer.vim.git
    vim -c "helptags ~/.vim/bundle/closer.vim/doc" -c q

Put these lines into your `~/.vimrc`

    set runtimepath+=$HOME/.vim/bundle/closer.vim
    nmap <silent> <localleader>c <Plug>OpenCloser

Updating
========

The plugin can be updated with the following commands

    cd ~/.vim/bundle/closer.vim
    git pull
    vim -c "helptags ~/.vim/bundle/closer.vim/doc" -c q
