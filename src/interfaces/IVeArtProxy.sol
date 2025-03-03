// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVeArtProxy {
    function _tokenURI(
        uint _tokenId,
        uint _balanceOf,
        uint _locked_end,
        uint _value
    ) external view returns (string memory output);
}
