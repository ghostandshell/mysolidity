// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EthUnitTest{

    uint256 num1 = 1;

    function testEther(uint256 param) external view returns(uint256) {
        return param*1 ether + num1;
    }

    function testWei(uint256 param) external view returns(uint256) {
        return 1 wei * param + num1;
    }

    function testGwei(uint256 param) external view returns(uint256) {
        return 1 gwei * param + num1;
    }
}