use dojo::test_utils::deploy_contract;
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use dojo::test_utils::spawn_test_world;
use array::ArrayTrait;
use starknet::{
    syscalls::deploy_syscall,ClassHash, ContractAddress
};

use dojo_web3mq_modules::systems::user::contract::user_systems;
use dojo_web3mq_modules::models::{user, User};
use dojo_web3mq_modules::models::{follow, Follow};
use dojo_web3mq_modules::models::{block, Block};
use dojo_web3mq_modules::models::{permission, Permission};
use dojo_web3mq_modules::systems::user::interface::{IUserDispatcher, IUserDispatcherTrait};
use core::traits::Into;
use debug::PrintTrait;

#[test]
#[available_gas(3000000000000000)]
fn test_user(){
    let mut models = array![user::TEST_CLASS_HASH, follow::TEST_CLASS_HASH, block::TEST_CLASS_HASH, permission::TEST_CLASS_HASH];
    let world: IWorldDispatcher = spawn_test_world(models);
    starknet::testing::set_contract_address(world.executor());
    let (user_systems, _) = deploy_syscall(user_systems::TEST_CLASS_HASH.try_into().unwrap(), 0, array![].span(), false).unwrap();
    let user_systems_dispatcher = IUserDispatcher {
        contract_address: user_systems
    };
    let user_id = user_systems_dispatcher.register(world, 1.try_into().unwrap());
    user_id.print();
    user_systems_dispatcher.block(world, 1.try_into().unwrap(), 2.try_into().unwrap(),true);
    user_systems_dispatcher.follow(world, 1.try_into().unwrap(), 2.try_into().unwrap(),true);
    user_systems_dispatcher.set_permission(world, 1.try_into().unwrap(), 1);
    
    // user_systems_dispatcher.invite(world, group_id, 1.try_into().unwrap(), 2.try_into().unwrap());

    // //user_systems_dispatcher.join(world, group_id, 1.try_into().unwrap());

    // user_systems_dispatcher.set_group_permission(world, 1.try_into().unwrap(), group_id, 1);

    // user_systems_dispatcher.set_member_permission(world, group_id, 1.try_into().unwrap(), 2.try_into().unwrap(), 1)
}