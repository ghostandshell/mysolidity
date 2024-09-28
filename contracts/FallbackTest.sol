// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract FallbackTest{
    event Log(string funame, address from, uint value, bytes data);
    function deposite() external payable{}

    fallback() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }

    // receive() external payable { // This is the receive function to handle the received Ether
    //     emit Log("receive", msg.sender, msg.value, "");
    // }

    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}