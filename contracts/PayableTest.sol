// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Strings.sol";


/**
 * deposite1 : 支付value里设置的代币
 * deposite2 ： 无法支付代币，value中填值会报错
 * withdraw1 : 将当前合约的余额全部提取到合约调用者
 * withdrawTo : //向传入的地址转币
 * getBalance ： 获取当前合约的余额
 */
contract PayableTest{
    function deposite1() external payable {} //标记了payable，可以支付代币
    function deposite2() external {} //没有标payable，该方法不能支付代币 transact to PayableTest.deposite2 errored: Error occurred: revert.
    function withdraw1() external {
        payable (msg.sender).transfer(address(this).balance); //将当前合约的余额全部提取到合约调用者
    }
    function withdrawTo(address _addr) external {
        payable (_addr).transfer(address(this).balance); //向传入的地址转币
    }
    function getBalance() external view returns(uint256){
        return address(this).balance;
    }

    //  fallback() external payable { }  //会出警告This contract has a payable fallback function, but no receive ether function. Consider adding a receive ether function.
}

/**
 * 定义了一个接口AnimalMove，以及其实现Cat类，AnimalMove定义了eat方法，而Cat没有eat方法。
 * 在AnimalStart强行调用传入地址的eat方法，当使用Call的方式调用时，会绕过检查，并调用Cat的callback方法
 * 
 */
contract Cat {
    event eventFallback(string);

    //0x311d8dfc1358105E8dc45564444B4612981099DD run带return
    function run() external pure returns (string memory){
        console.log("---------run");
        return "run";
    }
    //0x135A665d7544c8ce64Bc9e0688Fc0Bd7BF505407 run不带return，和接口不一致，console会执行，也会报错
    // function run() external pure{
    //     console.log("---------run");
    // }
    using Strings for uint256;
    function run(uint256 param) external pure returns (string memory){
        console.log(string(abi.encodePacked("---------run", param.toString())));
        return string(abi.encodePacked("run:" , param.toString())); //使用toString转化uint
    }

    fallback() external  { //通过abi调eat方法的请求会走这里，因为Cat没有eat方法, 但是转币会报错，要加payable
        emit eventFallback("fallback");
        console.log("----------fallback");
    }
}

interface AnimalMove {
    function eat() external pure returns (string memory);
    function run() external pure returns (string memory);
}

contract AnimalStart {
    function doEat(address _addr) external  pure returns(string memory){ //这个会检测，实现没有方法会报错
        AnimalMove am  =  AnimalMove(_addr);
        return am.eat(); //通过接口调用传入地址的eat方法
    }

    function doEatAbi(address _addr) external   returns(bool success) {  //这种call的方式调用会绕过合约的检测
        AnimalMove am  =  AnimalMove(_addr);
        (success,)=address(am).call(abi.encodeWithSignature("eat()"));//通过call调用eat方法
        require(success);
    }

    function doRun(address _addr) external  pure returns(string memory){ //这个会检测，没有方法会报错
        AnimalMove am  =  AnimalMove(_addr);
        return am.run(); //通过接口调用传入地址的run方法
    }
    function doRunAbi(address _addr) external   returns(bool success) {  //这种call的方式调用会绕过合约的检测
        AnimalMove am  =  AnimalMove(_addr);
        (success,)=address(am).call(abi.encodeWithSignature("run()"));//通过call调用run方法
        require(success);
    }
}