# No repositório remoto
- Na pasta do repositório, na pasta `hooks`, criar um arquivo chamado **post-receive**
- Dar permissão de execução (`chmod +x post-receive`)
- Inserir o seguinte trecho:
    ```bash
    #!/bin/sh
    git push -f ssh://<usuário no servidor>@<IP do servidor>:<porta de acesso><Caminho no servidor para o repositório bare> <branch de origem>:<branch de destino>
    ```
- Alternativamente (recomendada):
    ```bash
    #!/bin/sh
    git push -f ssh://<usuário no servidor>@<alias do servidor><Caminho no servidor para o repositório bare> <branch de origem>:<branch de destino>
    ```
- Caso a segunda opção seja utilizada, aa seguinte configuração deverá ser adicionada às configurações do SSH
  (essas configurações geralmente se encontram na no arquivo **config** na pasta **.ssh** na home do usuário:
    ```bash
    Host <alias do servidor>
        Hostname        <IP do servidor>
        Port            <A porta a ser utilizada na conexão>
        User            <usuário no servidor>
        IdendityFile    <Caminho para o arquivo contendo a chave privada>
        IdentitiesOnly  yes
    ```

#No servidor de deploy
- Clonar o repositório no servidor de deploy com a flag `--bare`
- No repositório recém clonado, na pasta `hooks`, criar um arquivo chamado **post-receive**
- Dar permissão de execução
- Inserir o seguinte trecho:
    ```bash
    #!/bin/sh
    GIT_WORK_TREE=<Caminho para o diretório contendo o código> git checkout -f <branch de destino>
    #Insira quaisquer outros comandos que devam ser executados após o git pull
    #como 'npm install' e/ou 'npm run build'
    ```
