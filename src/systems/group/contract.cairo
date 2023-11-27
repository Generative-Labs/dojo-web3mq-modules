#[dojo::contract]
mod group_systems{
    use starknet::ContractAddress;
    use dojo_web3mq_modules::models::{Group, Member};
    use dojo_web3mq_modules::systems::group::interface::IGroup;
    use dojo_web3mq_modules::utils::bytes::{Bytes, BytesTrait};
    use debug::PrintTrait;
    #[external(v0)]
    impl GroupImpl of IGroup<ContractState>{
        fn create_group(self: @ContractState, world: IWorldDispatcher, permission: u32, creator: ContractAddress) -> u256{
            assert(creator == starknet::get_caller_address(), 'creator is not caller');
            let mut bytes: Bytes = BytesTrait::new(0, array![]);
            bytes.append_felt252('WEB3MQ_GROUP_ID');
            bytes.append_felt252(creator.into());
            bytes.append_u64(starknet::get_block_timestamp());
            let group_id = bytes.keccak();
            set!(world, Group{
                group_id: group_id,
                creator: creator,
                permission: permission
            });

            set!(world, Member{
                group_id: group_id,
                address: creator,
                permission: 0
            });
            return group_id;
        }

        //TODO sender and target must be friend 
        fn invite(self: @ContractState, world: IWorldDispatcher, group_id: u256, sender: ContractAddress, target: ContractAddress){
            assert(sender == starknet::get_caller_address(), 'caller is not sender');
            let group: Group = get!(world, group_id ,Group);
            group.permission.print();
            assert(group.permission <= 1, 'group permission denied');
            let send_member: Member = get!(world, (group_id, sender), Member);
            assert(send_member.permission <= 1, 'sender has no invite permission');
            set!(world, Member{
                group_id: group_id,
                address: target,
                permission: 2
            });
        }

        fn join(self: @ContractState, world: IWorldDispatcher, group_id: u256, member: ContractAddress){
            assert(member == starknet::get_caller_address(), 'caller is not member');
            let group: Group = get!(world, group_id ,Group);
            assert(group.permission == 0, 'group permission denied');
            set!(world, Member{
                group_id: group_id,
                address: member,
                permission: 2
            });
        }

        fn set_group_permission(self: @ContractState, world: IWorldDispatcher, creator: ContractAddress, group_id:u256, permission: u32){
            assert(creator == starknet::get_caller_address(), 'caller is not creator');
            let group: Group = get!(world, group_id, Group);
            assert(group.creator == creator, 'only creator can set permission');
            set!(world, Group{
                group_id: group.group_id,
                creator: group.creator,
                permission: permission
            });
        }

        fn set_member_permission(self: @ContractState, world: IWorldDispatcher, group_id:u256, sender: ContractAddress, target:ContractAddress, permission: u32){
            assert(sender == starknet::get_caller_address(), 'caller is not sender');
            assert(permission > 0 , 'permission must > 0');
            let sender_member:Member = get!(world, (group_id, sender), Member);
            assert(sender_member.permission <= 1, 'sender no permission');
            set!(world, Member{
                group_id: group_id,
                address: target,
                permission: permission
            });
        }
    }
}