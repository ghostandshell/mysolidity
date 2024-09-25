// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
// import * as ttt from "./TypeTest.sol";
import "./TypeTest.sol" as ttt;

/**
 * @title HelloWorld
 * @dev HelloWorld
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract HelloWorld{

    string public name  ;
    uint public age;
    address public msgSenderAddress;
    
    

    constructor(uint _age, string memory _name ) {
        console.log("Owner contract deployed by:", _name);
        age=_age;
        name=_name;
    }

    function changeTo(string memory newname ) public  {
        name = newname;
        console.log ("name has been changed to ", name);
    }

    function dothing() public view returns (string memory) {
        console.log ("hello world");
        console.log ("name:", name);
        console.log ("age:", age);
        return name;
         // console.log ("age:", this.age);
    }

    function getMyAddress1() external view returns(address) {
        return address(this);
    }

    function getMyAddress2() external view returns(address) {
        return this.getMyAddress1(); //用this绕过getMyAddress1的关键字限制，相当于从外部访问
    }

    function getMsgSenderAddress() external returns(address) {
        msgSenderAddress = msg.sender; //address of the account that is currently executing the contract's function
        return msgSenderAddress;
    }

    function getContractName() public pure returns (string memory) {
        return type(ttt.TypeTest).name;
    }

    function getRuntimeCode() public pure returns (bytes memory) {
        return type(ttt.TypeTest).runtimeCode;
    }

    function getCreationCode() public pure returns(bytes memory) {
        return type(ttt.TypeTest).creationCode;
    }

} 

