// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/**
 * @title InterfaceTest
 * @dev InterfaceTest
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract InterfaceTest {
    function doTest(address _address) public pure  {
        AnimalMove am = AnimalMove(_address);
        am.eat();
    }
}

/**
 * @title AnimalMove
 * @dev AnimalMove
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
interface AnimalMove{
    function eat() external pure returns(string memory);

    function run() external pure returns(string memory);
}

/**
 * @title Dog
 * @dev Dog
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Dog {
    string public animalName = "Dogs";
    function eat() public view returns(string memory) {
        string memory _animalName = this.animalName();
        string memory ret = string(abi.encodePacked(_animalName, " can eat"));
        console.log(ret);
        return ret;
    }
    function run() public view returns(string memory) {
        string memory _animalName = this.animalName();
        string memory ret = string(abi.encodePacked(_animalName, " can run"));
        console.log(ret);
        return ret;
    }
}