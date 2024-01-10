Vault Operations Cheat Sheet
============================

## Server


### Start Server

```bash
vault server -dev
```

### Initialize Server

```bash
vault operator init
```

### Unseal Server

```bash
vault operator unseal
```
ogin
```


## Secr
### Status

```bash
vault status
```

## Raft Storage

### Join Raft Storage

```bash
vault operator raft join <address>
```

### Remove Raft Storage

```bash
vault operator raft remove-peer <address>
```

### List Raft Storage

```bash
vault operator raft list-peers
```



## CLI Login

### Login using Token


```bash
export VAULT_ADDR=<address>
export VAULT_TOKEN=<token>
vault login
```

### Login using Userpass

```bash
export VAULT_ADDR=<address>
vault login -method=userpass username=<username>
```


## Secret Engines

### List Secret Engines

```bash
vault secrets list
```

### Enable Secret Engine

```bash
vault secrets enable <path> <type>
```

### Disable Secret Engine

```bash
vault secrets disable <path>
```

### KV Secret Engine

#### Enable KV Secret Engine

```bash
vault secrets enable -path=<path> -version=<version> kv
```

#### Write KV Secret

```bash
vault kv put <path> <key>=<value>
```

#### Read KV Secret

```bash
vault kv get <path>
```

#### Delete KV Secret

```bash
vault kv delete <path>
```

#### List KV Secrets

```bash
vault kv list <path>
```

#### Read KV Secret Metadata

```bash
vault kv metadata get <path>
```


## Policies

### List Policies

```bash
vault policy list
```

### Create Policy

```bash
vault policy write <name> <path>
```

### Read Policy

```bash
vault policy read <name>
```

### Delete Policy

```bash
vault policy delete <name>
```


## Tokens

### List Tokens

```bash
vault token list
```

### Create Token

```bash
vault token create
```

### Read Token

```bash
vault token lookup <token>
```

### Delete Token

```bash
vault token revoke <token>
```


## Auth Methods

### List Auth Methods

```bash
vault auth list
```

### Enable Auth Method

```bash
vault auth enable <path> <type>
```

### Disable Auth Method

```bash
vault auth disable <path>
```

### Read Auth Method

```bash
vault auth read <path>
```

### Write Auth Method

```bash
vault auth write <path> <options>
```

