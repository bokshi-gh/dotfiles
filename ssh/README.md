
# Generating SSH key pair and adding to SSH agent => 
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com" && eval "$(ssh-agent -s)" && ssh-add /path/to/id_rsa
# ssh with remote host device password => ssh username@remote_host
# ssh with key => ssh -i /path/to/id_rsa/file username@remote_host
# Copy a file from the remote server to your local machine => scp username@remote_host:/path/to/remote/file /path/to/local/directory
# Copy a file from the local machine to your remote server => scp /path/to/local/file username@remote_host:/path/to/remote/directory
# Execute a command on a remote server => ssh username@remote_host 'command'
# Flags:
#       -T => Disables the terminal allocation
# known_hosts file => Stores a list of known hosts for verifying the identity of the remote host.
#                     Once you have connected to a remote server and its fingerprint is stored in your known_hosts file,
#                     SSH will use this fingerprint to verify the server's identity during subsequent connections.
#                     No need to use the ID for subsequent connections.
