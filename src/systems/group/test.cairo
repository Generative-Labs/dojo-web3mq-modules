use dojo::test_utils::deploy_contract;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use dojo::test_utils::spawn_test_world;
use array::ArrayTrait;
use starknet::{
    syscalls::deploy_syscall,ClassHash, ContractAddress
};

use dojo_web3mq_modules::systems::group::contract::group_systems;
use dojo_web3mq_modules::models::{group, Group};
use dojo_web3mq_modules::models::{member, Member};
use dojo_web3mq_modules::systems::group::interface::{IGroupDispatcher, IGroupDispatcherTrait};
use core::traits::Into;
use debug::PrintTrait;

#[test]
#[available_gas(3000000000000000)]
fn test_group(){
    let mut models = array![group::TEST_CLASS_HASH, member::TEST_CLASS_HASH];
    let world: IWorldDispatcher = spawn_test_world(models);
    starknet::testing::set_contract_address(world.executor());
    let (group_systems, _) = deploy_syscall(group_systems::TEST_CLASS_HASH.try_into().unwrap(), 0, array![].span(), false).unwrap();
    let group_systems_dispatcher = IGroupDispatcher {
        contract_address: group_systems
    };
    let group_id = group_systems_dispatcher.create_group(world, 0, 1.try_into().unwrap(), 0);
    group_id.print();

    group_systems_dispatcher.invite(world, group_id, 1.try_into().unwrap(), 2.try_into().unwrap());

    //group_systems_dispatcher.join(world, group_id, 1.try_into().unwrap());

    group_systems_dispatcher.set_group_permission(world, 1.try_into().unwrap(), group_id, 1);

    group_systems_dispatcher.set_member_permission(world, group_id, 1.try_into().unwrap(), 2.try_into().unwrap(), 1)
}