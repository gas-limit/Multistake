// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Registry {

// Ethereum: 101
// Avalanche: 106
// Polygon: 109
// Fantom: 112

    mapping(uint16 => uint256) public StargateIdToChainId;
    mapping(uint256 => uint16) public ChainIdToStargateId;

    // uint256 public ETHChainId;
    // uint256 public AVAXChainId;
    // uint256 public MATICChainId;
    // uint256 public FTMChainId;

    constructor(){

    //     ETHChainId = 1;
    //     AVAXChainId = 413114;
    //     MATICChainId = 109;
    //     FTMChainId = 112;

        StargateIdToChainId[101] = 1;
        StargateIdToChainId[106] = 43114;
        StargateIdToChainId[109] = 137;
        StargateIdToChainId[112] = 250;

        ChainIdToStargateId[1] = 101;
        ChainIdToStargateId[413114] = 106;
        ChainIdToStargateId[137] = 109;
        ChainIdToStargateId[250] = 112;




    }

    // function getStargateId(uint16 chainId) public view returns (uint16) {
    //     return ChainIdToStargateId[chainId];
    // }

    // function setStargateId(uint16 chainId, uint16 stargateId) public {
    //    ChainIdToStargateId[chainId] = stargateId;
    // }
    

    // function getETHChainId() public view returns (uint256) {
    //     return ETHChainId;
    // }

    // function getAVAXChainId() public view returns (uint256) {
    //     return AVAXChainId;
    // }

    // function getMATICChainId() public view returns (uint256) {
    //     return MATICChainId;
    // }

    // function getFTMChainId() public view returns (uint256) {
    //     return FTMChainId;
    // }
    



    
}