# SSH

## Installation

Install OpenSSH:

```sh
sudo pacman -S openssh
```

## Generating an SSH Key Pair

Generate a new Ed25519 SSH key pair:

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

- `-t ed25519` specifies the Ed25519 key type.
- `-C` adds a comment to the public key, usually an email address.
- `-f` specifies the file path and filename for the key pair.
- If `-f` is not specified, SSH uses the default files:
  - Private key: `~/.ssh/id_ed25519`
  - Public key: `~/.ssh/id_ed25519.pub`
* The public key can be added to the remote server's `~/.ssh/authorized_keys`.

### Copying the Public Key to a Server

You can copy your public key to a remote server with:

```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub username@remote_host
```

You will normally enter the remote user's password once. After the key has been authorized, SSH can authenticate using the key instead of the account password.

You can also add the public key manually to:

```text
~/.ssh/authorized_keys
```

Each authorized public key occupies its own line:

```text
ssh-ed25519 AAAA... user@hostname
ssh-ed25519 BBBB... another_user@hostname
```

## SSH with Remote Host

Connect to a remote server:

```sh
ssh username@remote_host
```

SSH will use the configured identity files and authentication methods. If key authentication is unavailable, the server may prompt for the user's password.

## SSH with a Specific Key

Specify a private key with `-i`:

```sh
ssh -i ~/.ssh/id_ed25519 username@remote_host
```

The `-i` option specifies the private identity file used for authentication.

If `-i` is not specified, SSH searches its configured identity files and uses the applicable keys.

## Copying Files with SCP

### Remote → Local

Copy a file from a remote server to your local machine:

```sh
scp username@remote_host:/path/to/remote/file /path/to/local/directory
```

### Local → Remote

Copy a file from your local machine to a remote server:

```sh
scp /path/to/local/file username@remote_host:/path/to/remote/directory
```

## Execute Commands on a Remote Server

Run a command directly on a remote server:

```sh
ssh username@remote_host 'command'
```

For example:

```sh
ssh username@remote_host 'uname -a'
```

This executes the command remotely without opening an interactive shell.

### Disable Terminal Allocation

Use `-T` when a terminal is not required:

```sh
ssh -T username@remote_host 'command'
```

## SSH Agent

The SSH agent stores private keys in memory and performs authentication on behalf of SSH. This is useful when your private key has a passphrase because you don't need to enter the passphrase for every connection.

Start the agent:

```sh
eval "$(ssh-agent -s)"
```

Add a private key:

```sh
ssh-add ~/.ssh/id_ed25519
```

List keys currently loaded into the agent:

```sh
ssh-add -l
```

Remove all keys from the agent:

```sh
ssh-add -D
```

## `authorized_keys`

The `authorized_keys` file is located on the remote server at:

```text
~/.ssh/authorized_keys
```

It contains the public keys that are allowed to authenticate as that user.

Each public key should be on its own line.

Typical permissions are:

```sh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## `known_hosts`

The `known_hosts` file is located on the local machine at:

```text
~/.ssh/known_hosts
```

It stores information used by SSH to recognize servers you have previously connected to.

When connecting to a server for the first time, SSH may display the server's host key fingerprint and ask you to confirm it.

Do not blindly accept an unexpected host-key change.

## SSH Config

The SSH client configuration file is:

```text
~/.ssh/config
```

It allows you to define reusable settings for different hosts.

Example:

```sshconfig
Host *
    AddKeysToAgent yes

Host example
    HostName example.com
    User your_username
    Port 22
    RequestTTY no
    IdentityFile ~/.ssh/id_ed25519_example
```

### `Host *`

```sshconfig
Host *
    AddKeysToAgent yes
```

The `Host *` section applies to all SSH connections.

### Specific Host

```sshconfig
Host example
    HostName example.com
    User your_username
    Port 22
    IdentityFile ~/.ssh/id_ed25519_example
```

Now you can connect using:

```sh
ssh example
```

instead of:

```sh
ssh -i ~/.ssh/id_ed25519_example your_username@example.com
```

### Common SSH Config Options

| Option           | Purpose                              |
| ---------------- | ------------------------------------ |
| `Host`           | Defines a host alias                 |
| `HostName`       | Actual hostname or IP address        |
| `User`           | Remote username                      |
| `Port`           | SSH port                             |
| `IdentityFile`   | Private key to use                   |
| `AddKeysToAgent` | Adds keys to the SSH agent when used |
| `RequestTTY`     | Controls terminal allocation         |

## SSH File Overview

```text
~/.ssh/
├── config
├── id_ed25519
├── id_ed25519.pub
├── known_hosts
└── authorized_keys
```

`authorized_keys` normally exists on the **remote server**, while `known_hosts` normally exists on the **local machine**.
