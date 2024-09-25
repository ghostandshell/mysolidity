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
        string memory ret;
        ret = am.eat();
        console.log(ret);
        ret = am.run();
        console.log(ret);
    }
    function getInterfaceId() public pure returns(bytes4) {
        return type(AnimalMove).interfaceId;
    }
    function useLibrary() external   pure{
        Set.test();
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

library Set {
    struct Data{
        mapping (uint => bool) flags;
    }
    
    function test() external pure{
        console.log("Set.test");

    }

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
        return ret;
    }
    function run() public view returns(string memory) {
        string memory _animalName = this.animalName();
        string memory ret = string(abi.encodePacked(_animalName, " can run"));
        return ret;
    }
}

contract Cat {
    string public animalName = "Cats";
    function eat() public view returns(string memory) {
        string memory _animalName = this.animalName();
        string memory ret = string(abi.encodePacked(_animalName, " can eat"));
        return ret;
    }
    function run() public view returns(string memory) {
        string memory _animalName = this.animalName();
        string memory ret = string(abi.encodePacked(_animalName, " can run"));
        return ret;
    }
}