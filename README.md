# web3mq dojo modules

# Introduction

web3mq-dojo-modules is the modules on [dojo](https://github.com/dojoengine), which implement web3mq features like group and social relationship

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