#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear

printf "
#######################################################################
#                            install nvm                              #
#                                                                     #
#######################################################################
"

. ./versions.txt

wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_ver}install.sh" | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "install nvm v${nvm_ver} success!"