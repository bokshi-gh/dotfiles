**Generating SSH key pair**
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
**Adding to SSH agent**
- When you generate an SSH key pair, it often comes with a passphrase to protect the private key.   While this is a good security measure, it can become cumbersome if you need to enter the     passphrase each time you use the key.

- By adding your private key to the SSH agent, you only need to enter the passphrase once, and the   agent will handle authentication for future connections. This way, you can connect to remote  servers or execute commands without constantly typing the passphrase.
```sh
eval "$(ssh-agent -s)" 
ssh-add /path/to/id_rsa
```
**SSH with remote host device password**
```sh
ssh username@remote_host
```
**SSH with key**
```sh
 ssh -i /path/to/id_rsa/file username@remote_host
```
**Copy a file from the remote server to your local machine**
```sh
scp username@remote_host:/path/to/remote/file /path/to/local/directory
```
**Copy a file from the local machine to your remote server**
```sh
scp /path/to/local/file username@remote_host:/path/to/remote/directory
```
**Execute a command on a remote server**
```sh
ssh username@remote_host 'command'
```
**Port forwarding**
```sh
```

**Flags**
- T  => Disables the terminal allocation

**known_hosts file**
- Stores a list of known hosts for verifying the identity of the remote host.
- Once you have connected to a remote server and its fingerprint is stored in your known_hosts file,
- SSH will use this fingerprint to verify the server's identity during subsequent connections.
- No need to use the ID for subsequent connections.
