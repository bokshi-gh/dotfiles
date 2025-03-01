
# SSH Overview and Commands

## 1. **Generating SSH Key Pair**
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
- This command generates a new SSH key pair with the RSA algorithm (`-t rsa`) and a key length of 4096 bits (`-b 4096`).
- The `-C` flag adds a label (usually your email) for identifying the key.
- The key pair is stored in the `~/.ssh/` directory by default.
- If a custom name is not provided, the key pair files will be named `id_rsa` (private key) and `id_rsa.pub` (public key).
- After generating key pair paste the pubic key content to SSH server's authorized_keys file.
- authorized_keys file looks like this:
```
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArYHJ6jU+OnEwLOIhJz8LBX1nPRA6Oik9m4hklpqlyDAidFz9dKHtddMb4zrkDkSuTY4z6JfXbcT8bH6OXfGsA3GdAmwb9n8z44K5hQXsZy3qjdzssTY55M0PjYCTFSV+gjf96ZJvllqNN5gsseQZl0SZXqAPYkXggwRsqZgaLkgV2FNb1Kl6H8gPmI1ed3eRvoBXnyTXtXlbrX2Ez/8yyfBd1XpoRm5HzUBVw3A2zKqWYoFjWpxkMDCJbi/qvWwskA/2Ez3vhkmyw62gBhK8PlTZtZcW4rQ1lGfThgVfG1Oe9A29OSkjUEP3Wfr9XqI0XkZ3r5V6TmPzsh3hijXQPOEl1uFS0o8vvvWymnPQ4GGKhzI0wGtHw2pRtbd7e08+Hc3Qw== user@hostname
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtmUpX+Ymg7z5UE9y+Go6HRBYa3oFvhrpJ2geq5/JxN9lMKf5Ls17rwP1GV6hddjzZoHtYq44JvH1CGvZhUdmF61Rh3e0Em8J8yMLp/j2S7hfNm0AKn1unRFLVlfcuFggZn9mvoTpq7uAMi3VAHHf4plTmC4gHe95p7a34TmPG1ZmRtjmIMuFmu4sb0K5WVdT6ohCSM8nBbg1A== another_user@hostname
```

## 2. **Adding to SSH Agent**
- The SSH agent stores your keys and handles authentication for you, so you don’t need to re-enter the passphrase each time.
```sh
eval "$(ssh-agent -s)"
ssh-add /path/to/id_rsa
```
- `eval "$(ssh-agent -s)"` starts the SSH agent in the background.
- `ssh-add /path/to/id_rsa` adds your private key to the agent for authentication.

## 3. **SSH with Remote Host (Password Authentication)**
```sh
ssh username@remote_host
```
- This command connects to a remote server using the provided username and prompts you for a password (unless you’re using SSH keys for authentication).

## 4. **SSH with Key (No Password)**
```sh
ssh -i /path/to/id_rsa/file username@remote_host
```
- This allows SSH authentication using the private key (`-i` option), without entering a password, if your key is authorized on the remote server.
- If `-i` is not provided, the default key used is `~/.ssh/id_rsa`.

## 5. **Copying Files with SCP (Secure Copy)**
- Copy a file from remote server to local machine:
  ```sh
  scp username@remote_host:/path/to/remote/file /path/to/local/directory
  ```
- Copy a file from local machine to remote server:
  ```sh
  scp /path/to/local/file username@remote_host:/path/to/remote/directory
  ```

## 6. **Execute Commands on a Remote Server**
```sh
ssh username@remote_host 'command'
```
- This runs a command directly on the remote server without logging into an interactive session.

## 7. **Using Different Port**
```sh
ssh -p 2222 username@remote_host
```
- If the SSH service on the remote server is running on a different port (e.g., 2222), you can specify it with the `-p` flag.
- If the port is not specified, SSH defaults to port `22`.

## 8. **Port Forwarding**
- Port forwarding lets you tunnel a port from your local machine to a remote machine.
  ```sh
  ssh -L local_port:remote_host:remote_port username@remote_host
  ```
- This will forward traffic from `local_port` on your local machine to `remote_port` on the `remote_host`.

## 9. **Flags**
- **`-T`**: Disables terminal allocation (useful when you don’t need a terminal, such as when executing commands non-interactively).
  ```sh
  ssh -T username@remote_host 'command'
  ```

## 10. **`authorized_keys` File**
- Located on the remote server in `~/.ssh/authorized_keys`, this file contains the public keys of users who are authorized to log in to the server without a password.

## 11. **`known_hosts` File**
- Located on your local machine in `~/.ssh/known_hosts`, this file stores the fingerprints of remote hosts you’ve connected to. It’s used to verify the identity of the server during future connections.

## 12. **SSH Config File**
- Located on your local machine in `~/.ssh/config`.
- Simplifies connecting to multiple hosts with specific configurations:
  ```txt
  Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_rsa

  Host example
      HostName example.com
      User your_username
      Port 22
      RequestTTY no
      IdentityFile ~/.ssh/id_rsa_example
  ```
- The `Host *` section applies to all hosts, setting up common options.
- Specific hosts can have unique settings, such as a different port or identity file.
- Use `ssh example` to execute.
