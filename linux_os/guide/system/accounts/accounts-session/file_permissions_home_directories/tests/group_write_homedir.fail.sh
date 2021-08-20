username="testuser"
homedir=/home/${username}
useradd -m -U ${username}

chmod g+w ${homedir}
