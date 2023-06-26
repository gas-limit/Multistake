// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/IStargateRouter.sol";
import "../interfaces/IStargateReceiver.sol";
import "../interfaces/IStargateWidget.sol";


contract GoerliHub is IStargateReceiver {
    using SafeERC20 for IERC20;

    address public stargateRouter;      // an IStargateRouter instance
    address public widgetSwap;
    bytes2 public partnerId;

    //phantom stargate chain id: 10112
    //mumbai stargate chain id: 10109
    uint16 GoerliId = 10121;
    uint16 FujiId = 10106;

    address USDC = 0xDf0360Ad8C5ccf25095Aa97ee5F2785c8d848620;

    address destinationAddress;

    event ReceivedOnDestination(address token, uint qty);

    constructor(address _stargateRouter, address _destinationAddress) {
        stargateRouter = _stargateRouter;
        destinationAddress = _destinationAddress;
    }

    // Swap 1 USDC for 1 ftm on spookyswap
    


    //1. swap USDC on fantom to another chain 

    function swap(uint256 amount, bytes calldata someMsg) public payable  {
        require(msg.value > 0, "stargate requires a msg.value to pay crosschain message");
        //require swap > 0

        // encode payload data to send to destination contract, which it will handle with sgReceive()
        // bytes memory data = abi.encode(to);

        IERC20(USDC).safeTransferFrom(msg.sender, address(this), amount);
        IERC20(USDC).safeApprove(address(stargateRouter), amount);

        

        IStargateRouter(stargateRouter).swap{value:msg.value}(
            FujiId,                                     // the destination chain id
             1, //USDC                                      // the source Stargate poolId
             1, //USDC                                     // the destination Stargate poolId
             payable(msg.sender),                            // refund adddress. if msg.sender pays too much gas, return extra eth
            amount,                                            // total tokens to send to destination chain
             0,    // 0 for now                                          // min amount allowed out
             IStargateRouter.lzTxObj(200000, 0, "0x"),       // default lzTxObj
             abi.encodePacked(destinationAddress),         // destination address, the sgReceive() implementer
             someMsg                           // bytes payload
        );
    }


    // 2. bridge USDC to multiple chains



    // 3. stake on LSD protocol


    // 4. loan LSD on lending market








    //-----------------------------------------------------------------------------------------------------------------------
    // sgReceive() - the destination contract must implement this function to receive the tokens and payload
    function sgReceive(uint16 /*_chainId*/, bytes memory /*_srcAddress*/, uint /*_nonce*/, address _token, uint amountLD, bytes memory _payload) override external {
        // require(msg.sender == address(stargateRouter), "only stargate router can call sgReceive!");
        // (address _toAddr) = abi.decode(_payload, (address));
        // // send transfer _token/amountLD to _toAddr
        // IERC20(_token).transfer(_toAddr, amountLD);
        // emit ReceivedOnDestination(_token, amountLD);
    }

}