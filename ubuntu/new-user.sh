set -e
USERNAME=$1
adduser "$USERNAME"
usermod -aG sudo "$USERNAME"

cp -R .ssh "/home/$USERNAME/"
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"

exec su - "$USERNAME"
