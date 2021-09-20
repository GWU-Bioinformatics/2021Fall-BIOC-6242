## Overview
This directory contains files intended to be used as profile configurations for users setting up new SSH sessions. 
Some files should be linked in the home directory, while others are sourced from e.g. the bashrc file. Linked files (and target locations) are:  
  |\<FILE\>|\<LINKED LOCATION\>|
  |--------|-------------------|
  |`dotfiles/bashrc`|`~/.bashrc`|
  |`dotfiles/vimrc`|`~/.vimrc`|
  |`dotfiles/tmux.conf`|`~/.tmux.conf`|

Symbolically link files as `ln -s <FILE> <LINK NAME>`

## NOTE: For PuTTY users
Set session information roughly as follows:  
 - Connection &rarr; Data &rarr; "Terminal-type string": xterm-color
 - Session &rarr; \<username\>@128.164.35.92  

Type a name for the session and click save to store your connection information

## For other terminal sessions  
If the commandline doesn't appear to have new colors, or otherwise appears to be malformed, try the following:
 - Uncomment the `force_color_prompt=yes` line (see `bashrc:41`)
 - When launching your ssh session, prepend `TERM=xterm-color` to the command (ie, `TERM=xterm-color ssh [args]`)

## Additional resources ##
### These are all _optional_, but worth looking into as you develop your programming expertise
Git:  
 - GitHub quickstart: https://docs.github.com/en/get-started/quickstart
 - A good description of version control: https://www.atlassian.com/git/tutorials/what-is-version-control

**NB**: GitHub and Bitbucket (Atlassian) both provide central git hosting; git itself is the tool that interacts with these services

R/Bioconductor:
 - The R project: https://cran.r-project.org/
 - Bioconductor (Collected R Bioinformatics tools): https://www.bioconductor.org/

bash customization:
 - Sample command-line updates: https://github.com/ohmybash/oh-my-bash
 - Additional tools: https://github.com/awesome-lists/awesome-bash

Vim customization:
 - Some non-scripted updates: https://gist.github.com/simonista/8703722
 - Vundle (scripted package management): https://github.com/VundleVim/Vundle.vim
 - Curated packages for Vim: https://vimawesome.com/

tmux:
 - Standard command palette: https://tmuxcheatsheet.com
 - A fancy sample configuration: https://github.com/gpakosz/.tmux
