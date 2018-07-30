#!/bin/bash

help()
{
    echo "To add git hook script on deploy server:"
    echo "  '$1 <user on deploy server> <deploy server's IP> <port> <path to bare directory> <folder with the code>  <destiny branch> '"
    echo "To print this menu: '$1 -h' or '$1 --help'"
}

if [ $# -gt 0 ]; then
    if [ "$1"  = "-h" ] || [ "$1" = "--help" ] ; then
        help $0
    elif [ $# -lt 6 ]; then
        echo "Wrong number of arguments"
        echo "Usage:"
        help $0
    else    
        ssh $1@$2 -p $3 "cd $4/hooks && touch post-receive && chmod +x post-receive && echo \"#!/bin/bash\" >> post-receive && echo \"GIT_WORK_TREE=$5 git checkout -f $6\" >> post-receive"        
    fi;
else 
    echo "Wrong number of arguments"
    echo "Usage:"
    help $0
fi;
