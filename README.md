# web3mq dojo

# Introduction

web3mq-dojo is a project based on [dojo](https://github.com/dojoengine), which is used to store on-chain gaming social relationship.

# Running

You need to learn on [dojo book](https://book.dojoengine.org/cairo/hello-dojo.html) firstly.

running this project:

- build

```rust
sozo build
```

- test

```rust
sozo test
```

# Design

### Component

```rust
#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Bind{
    #[key]
    sender: ContractAddress,
    web3mq_id: felt252
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Follow{
    #[key]
    sender: ContractAddress,
    #[key]
    target: ContractAddress,
    follow: bool
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Block{
    #[key]
    sender: ContractAddress,
    #[key]
    target: ContractAddress,
    block: bool
}

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Permission{
    #[key]
    sender: ContractAddress,
    permission: u32
}
```

### System

- bind

```rust
#[system]
mod bind_{
    fn execute(ctx: Context, sender_address:ContractAddress, web3mq_id:felt252)
}
```

- follow

```rust
#[system]
mod follow_{
    fn execute(ctx: Context, sender_address:ContractAddress, target_address:ContractAddress, follow: bool)
}
```

- block

```rust
#[system]
mod block_{
    fn execute(ctx: Context, sender_address:ContractAddress, target_address:ContractAddress, block: bool)
}
```

- permission

```rust
#[system]
mod permission_{
    fn execute(ctx: Context, sender_address:ContractAddress, permission:u32)
}
```
