use starknet::ContractAddress;
#[derive(Model, Copy, Drop, Serde)]
struct Group{
    #[key]
    group_id: u256,
    creator: ContractAddress,
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