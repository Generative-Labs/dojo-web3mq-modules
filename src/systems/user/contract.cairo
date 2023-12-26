#[dojo::contract]
mod user_systems{
    use starknet::ContractAddress;
    use dojo_web3mq_modules::models::{User, Block, Follow, Permission};
    use dojo_web3mq_modules::systems::user::interface::IUser;
    use dojo_web3mq_modules::utils::bytes::{Bytes, BytesTrait};
    use starknet::get_caller_address;
    use starknet::get_block_timestamp;
    use starknet::get_tx_info;
    #[external(v0)]
    impl UserImpl of IUser<ContractState>{
        fn register(self: @ContractState, world: IWorldDispatcher, address: ContractAddress) -> u256{
            let wallet_type = 'starknet';
            let wallet_address = get_caller_address();
            let timestamp = get_block_timestamp();
            let tx_info = get_tx_info().unbox();
            let nonce = tx_info.nonce;
            let chain_id = tx_info.chain_id;
            let mut bytes: Bytes = BytesTrait::new(0, array![]);
            bytes.append_felt252('WEB3MQ_USER_ID');
            bytes.append_felt252(wallet_type);
            bytes.append_felt252(chain_id);
            bytes.append_felt252(wallet_address.into());
            bytes.append_u64(timestamp);
            bytes.append_felt252(nonce);
            let user_id = bytes.keccak();
            set!(world, User{
                address: address,
                web3mq_id: user_id
            });
            return user_id;
        }
        fn block(self: @ContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, block: bool){
            set!(world, Block{
                sender: sender,
                target: target,
                block: block
            });
        }
        fn follow(self: @ContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, follow: bool){
            set!(world,Follow{
                sender: sender,
                target: target,
                follow: follow
            });
        }
        fn set_permission(self: @ContractState, world: IWorldDispatcher, address: ContractAddress, permission: u32){
            set!(world, Permission{
                sender: address,
                permission: permission
            })
        }
    }
}