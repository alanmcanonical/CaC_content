username="testuser"
homedir=/home/${username}
useradd -m -U ${username}

chmod o+x ${homedir}
