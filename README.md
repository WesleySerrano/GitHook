# Tutorial and scripts for creating Git hooks

Gists:
- [Script for deploy server](https://gist.github.com/WesleySerrano/cddb01e387d34269884bfde312a42a7a)
- [Script for repository server](https://gist.github.com/WesleySerrano/afc11e0b9d78fdd7df3fe79a5a64551c)

## On remote repo
- In the git repository directory, in the folder `hooks`, create a file named **post-receive**
- Grant execution (`chmod +x post-receive`)
- Add the following snippet:
    ```bash
    #!/bin/sh
    git push -f ssh://<deploy server user>@<deploy server IP>:<access port><Path to the bare repo in the deploy server> <origin branch>:<destiny branch>
    ```
- Alternatively (recommended):
    ```bash
    #!/bin/sh
    git push -f ssh://<deploy server user>@<deploy server alias><Path to the bare repo in the deploy server> <origin branch>:<destiny branch>
    ```
- In case you use the second option, the following snippet should be added to yours SSH configurations
  (these configurations are usually found in the **config** file in the **.ssh** folder at user's home:
    ```bash
    Host <deploy server alias>
        Hostname        <server IP>
        Port            <port to be used>
        User            <server user>
        IdendityFile    <Path to private key>
        IdentitiesOnly  yes
    ```

## On deploy server
- Clone the repo with the flag `bare`
- In the just clonned repository, in the folder `hooks`, create a file named **post-receive**
- Grant execution
- Add the following snippet:
    ```bash
    #!/bin/sh
    GIT_WORK_TREE=<Path to the folder with the code> git checkout -f <destiny branch>
    #Add any other commands that should be executed after git pull
    #like 'npm install' or 'npm run build'
    ```

## Useful commands:
- Some times, commands should be executed with **sudo** permission, to bypass this run the following:
  ```bash
  echo <user that will make the pull> ALL= NOPASSWD: <path to command executable> [flags or params if needed] | sudo tee --append /etc/sudoers > /dev/null
  ```
