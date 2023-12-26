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