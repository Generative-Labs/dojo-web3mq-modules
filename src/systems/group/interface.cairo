use dojo::world::IWorldDispatcher;
use starknet::ContractAddress;

#[starknet::interface]
trait IGroup<TContractState>{
    fn create_group(self: @TContractState, world: IWorldDispatcher, permission: u32, creator: ContractAddress) -> u256;
    fn invite(self: @TContractState, world: IWorldDispatcher, group_id: u256, sender: ContractAddress, target: ContractAddress);
    fn join(self: @TContractState, world: IWorldDispatcher, group_id: u256, member: ContractAddress);
    fn set_group_permission(self: @TContractState, world: IWorldDispatcher, creator: ContractAddress, group_id:u256, permission: u32);
    fn set_member_permission(self: @TContractState, world: IWorldDispatcher, group_id:u256, sender: ContractAddress, target:ContractAddress, permission: u32);
}