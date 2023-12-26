use dojo::world::IWorldDispatcher;
use starknet::ContractAddress;
#[starknet::interface]
trait IUser<TContractState>{
    fn register(self: @TContractState, world: IWorldDispatcher, address: ContractAddress) -> u256;
    fn block(self: @TContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, block: bool);
    fn follow(self: @TContractState, world: IWorldDispatcher, sender: ContractAddress, target: ContractAddress, follow: bool);
    fn set_permission(self: @TContractState, world: IWorldDispatcher, address: ContractAddress, permission: u32);
}