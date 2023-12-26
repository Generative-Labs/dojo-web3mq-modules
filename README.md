# web3mq dojo modules

# Introduction

web3mq-dojo-modules is the modules on [dojo](https://github.com/dojoengine), which implement web3mq features like group and social relationship.

# Running and Test

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

### User module

- model

```rust
#[derive(Model, Copy, Drop, Serde)]
struct User{
    #[key]
    address: ContractAddress,
	web3mq_id: u256
}

#[derive(Model, Copy, Drop, Serde)]
struct Follow{
    #[key]
    sender: ContractAddress,
	#[key]
    target: ContractAddress,
	follow: bool
}

#[derive(Model, Copy, Drop, Serde)]
struct Block{
    #[key]
    sender: ContractAddress,
	#[key]
    target: ContractAddress,
	block: bool
}

#[derive(Model, Copy, Drop, Serde)]
struct Permission{
    #[key]
    sender: ContractAddress,
    permission: u32
}
```

- systems

```rust
#[starknet::interface]
trait IUser<TContractState>{
    fn register(self: @TContractState, world: IWorldDispatcher, address: ContractAddress) -> u256;
    fn block(self: @TContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, block: bool);
    fn follow(self: @TContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, follow: bool);
    fn set_permission(self: @TContractState, world: IWorldDispatcher, address: ContractAddress, permission: u32);
}
```

### Group module

- model

```rust
use starknet::ContractAddress;
#[derive(Model, Copy, Drop, Serde)]
struct Group{
    #[key]
    group_id: u256,
    creator: ContractAddress,
	  metadata: u128,
    permission: u32
}

#[derive(Model, Copy, Drop, Serde)]
struct Member{
	  #[key]
	  group_id: u256,
	  #[key]
	  address: ContractAddress,
	  permission: u32
}
```

- systems

```rust
#[starknet::interface]
trait IGroup<TContractState>{
    fn create_group(self: @TContractState, world: IWorldDispatcher, permission: u32, creator: ContractAddress, metadata: u128) -> u256;
    fn invite(self: @TContractState, world: IWorldDispatcher, group_id: u256, sender: ContractAddress, target: ContractAddress);
    fn join(self: @TContractState, world: IWorldDispatcher, group_id: u256, member: ContractAddress);
    fn set_group_permission(self: @TContractState, world: IWorldDispatcher, creator: ContractAddress, group_id:u256, permission: u32);
    fn set_member_permission(self: @TContractState, world: IWorldDispatcher, group_id:u256, sender: ContractAddress, target:ContractAddress, permission: u32);
}
```