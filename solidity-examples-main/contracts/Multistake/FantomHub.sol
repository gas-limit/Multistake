// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/IStargateRouter.sol";
import "../interfaces/IStargateReceiver.sol";
import "../interfaces/IStargateWidget.sol";


contract FantomHub is IStargateReceiver {
    using SafeERC20 for IERC20;

    address public stargateRouter;      // an IStargateRouter instance
    address public widgetSwap;
    bytes2 public partnerId;

    //phantom stargate chain id: 112
    //arbitrum stargate chain id: 110

    

    event ReceivedOnDestination(address token, uint qty);

    constructor(address _stargateRouter, address _widgetSwap, bytes2 _partnerId) {
        stargateRouter = _stargateRouter;
        widgetSwap = _widgetSwap;
        partnerId = _partnerId;
    }

    // Swap 1 USDC for 1 ftm on spookyswap



    //1. swap USDC on fantom to another chain 

    function swap() public  {
        require(msg.value > 0, "stargate requires a msg.value to pay crosschain message");
        //require swap > 0

        // encode payload data to send to destination contract, which it will handle with sgReceive()
        // bytes memory data = abi.encode(to);

        // IERC20(bridgeToken).safeTransferFrom(msg.sender, address(this), qty);
        // IERC20(bridgeToken).safeApprove(address(stargateRouter), qty);

        IStargateRouter(stargateRouter).swap{value:msg.value}(
            // 110,                                     // the destination chain id
            // 1, //USDC                                      // the source Stargate poolId
            // 1,                                      // the destination Stargate poolId
            // payable(msg.sender),                            // refund adddress. if msg.sender pays too much gas, return extra eth
            // qty,                                            // total tokens to send to destination chain
            // 0,                                              // min amount allowed out
            // IStargateRouter.lzTxObj(200000, 0, "0x"),       // default lzTxObj
            // abi.encodePacked(destStargateComposed),         // destination address, the sgReceive() implementer
            // data                                            // bytes payload
        );
    }


    //2. bridge USDC to multiple chains



    //3. stake on LSD protocol


    //4. loan LSD on lending market








    //-----------------------------------------------------------------------------------------------------------------------
    // sgReceive() - the destination contract must implement this function to receive the tokens and payload
    function sgReceive(uint16 /*_chainId*/, bytes memory /*_srcAddress*/, uint /*_nonce*/, address _token, uint amountLD, bytes memory _payload) override external {
        require(msg.sender == address(stargateRouter), "only stargate router can call sgReceive!");
        (address _toAddr) = abi.decode(_payload, (address));
        // send transfer _token/amountLD to _toAddr
        IERC20(_token).transfer(_toAddr, amountLD);
        emit ReceivedOnDestination(_token, amountLD);
    }

}