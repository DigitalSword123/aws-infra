echo "branch name : "
echo $GITHUB_REF_NAME
if [ $GITHUB_REF_NAME == "main" ]
then
    sudo mkdir /.ssh && ls -alrt /.ssh
    git config --global user.name "Amiya Rana"
    git config --global user.email "ranaamiya70@gmail.com"
    # sudo cat ./ssh_keys/id_ed25519 >> ls -alrt /.ssh/id_ed25519
    # sudo cat ./ssh_keys/known_hosts >> ls -alrt /.ssh/known_hosts
    sudo cp ./ssh_keys/id_ed25519 /.ssh/id_ed25519 
    sudo cp ./ssh_keys/known_hosts /.ssh/known_hosts
    sudo chmod 400 /.ssh/id_ed25519 && chmod 400 /.ssh/known_hosts
    ls -alrt /.ssh
    git checkout main && git clean -f && git reset --hard origin/main
    mvn release:clean release:prepare release:perform _Darguments="-Dmaven.javadoc.skip=true" -DreleaseVersion=$version
else
    mvn clean deploy
fi