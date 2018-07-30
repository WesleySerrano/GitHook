#!/bin/bash

help()
{
    echo "To add git hook script on remote repo:"
    echo "  '$1 <user on repository server> <repository server's IP> <port> <path to repo directory> <path to bare directory> <origin branch> <destiny branch> <user in deploy server> <deploy server's IP> <deploy server port>'"
    echo "To print this menu: '$1 -h' or '$1 --help'"
}

if [ $# -gt 0 ]; then
    if [ "$1"  = "-h" ] || [ "$1" = "--help" ] ; then
        help $0
    elif [ $# -lt 10 ]; then
        echo "Wrong number of arguments"
        echo "Usage:"
        help $0
    else    
        ssh $1@$2 -p $3 "cd $4/hooks && touch post-receive && chmod +x post-receive && echo \"#!/bin/bash\" >> post-receive && echo \"git push -f ssh://$8@$9:$10$5 $6:$7\" >> post-receive"        
    fi;
else 
    echo "Wrong number of arguments"
    echo "Usage:"
    help $0
fi;
