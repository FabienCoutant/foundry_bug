//! Contract to mock ERC20 with specfic decimals
use starknet::ContractAddress;
use openzeppelin::token::erc20::interface::IERC20;
use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};

#[starknet::interface]
trait IMyContract<TContractState> {
    fn claim(ref self: TContractState, asset: IERC20Dispatcher, account: ContractAddress);
}


#[starknet::contract]
mod MyContract {
    use starknet::{ContractAddress, get_contract_address};
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    use snforge_std::PrintTrait;
    #[storage]
    struct Storage {}

    #[external(v0)]
    impl MyContractImpl of super::IMyContract<ContractState> {
        fn claim(ref self: ContractState, asset: IERC20Dispatcher, account: ContractAddress) {
            let balance = asset.balance_of(get_contract_address());

            asset.transfer(account, balance);
        }
    }
}
