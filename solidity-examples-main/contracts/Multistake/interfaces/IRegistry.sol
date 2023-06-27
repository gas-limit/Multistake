// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IRegistry {
    function getStargateId(uint256 chainId) external view returns (uint16);

    function getETHChainId() external view returns (uint256);
    function getAVAXChainId() external view returns (uint256);
    function getMATICChainId() external view returns (uint256);
    function getFTMChainId() external view returns (uint256);
}
