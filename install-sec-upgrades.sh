#!/usr/bin/env bash


MY_DISTRO=$(lsb_release -is)

# debian and ubuntu are "supported"

if [[ $MY_DISTRO = "Ubuntu" || $MY_DISTRO = "Debian" ]];
then

    apt update >/dev/null 2>&1

    PKG_LIST=$(apt list --upgradable 2>/dev/null | grep "\-security" |  grep "/" | cut -d/ -f1 )

    if [ -z "$PKG_LIST" ];
    then

        echo "No security packages to install"

    else

        echo "Command to run"
        echo "apt update; apt -y --only-upgrade install  "${PKG_LIST}

        read -r -p "Are you sure? [y/N] " response

        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
        then
            
            apt update; apt --only-upgrade install ${PKG_LIST}

        else
        
            echo "To keep the system safe, keep security updates up to date."
        
        fi

    fi

else

     # woops nothing to say

    echo "Unsupported linux distro"
    exit

fi
