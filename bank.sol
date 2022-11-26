// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
//Sanskar Laddha BE EXTC UID-2019120034

contract bankingsystem{
    mapping(address=>uint) public userAccount;
    mapping(address=>bool) public userExists;

    //creating user account using Boolean method by making userExists mapping true after using createAcc() function 
    function createAcc() public payable returns(string memory){
      require(userExists[msg.sender]==false,'Account Already Created');
      if(msg.value==0){
          userAccount[msg.sender]=0;
          userExists[msg.sender]=true;
          return 'account created';
      }
      require(userExists[msg.sender]==false,'account already created');
      userAccount[msg.sender] = msg.value;
      userExists[msg.sender] = true;
      return 'account created';
  }

  //With the help of userExists mapping -We are allowing only registered users to deposit into our Smart Contract Bank
  function deposit(uint dep) public payable returns(string memory){
      require(userExists[msg.sender]==true, 'Account is not created');
      require(dep>0, 'Value for deposit is Zero');
      userAccount[msg.sender]=userAccount[msg.sender]+dep;
      return 'Deposited Succesfully';
  }

  //Allow only registered users to withdraw money from their account and only if the user has sufficient balance in the account
  function withdraw(uint amount) public payable returns(string memory){
      require(userAccount[msg.sender]>amount, 'insufficeint balance in Bank account');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(amount>0, 'Enter non-zero value for withdrawal');
      userAccount[msg.sender]=userAccount[msg.sender]-amount;
      msg.sender.transfer(amount);
      return 'withdrawal Succesful';
  }

  //Function for transferring amount from one account to other account in the bank only and both users must have created account on the bank to use this function
  function TransferAmount(address payable userAddress, uint amount) public returns(string memory){

      require(userAccount[msg.sender]>amount, 'insufficient balance in Bank account');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(userExists[userAddress]==true, 'to Transfer account does not exists in bank accounts ');
      require(amount>0, 'Enter non-zero value for sending');
      userAccount[msg.sender]=userAccount[msg.sender]-amount;
      userAccount[userAddress]=userAccount[userAddress]+amount;

      return 'transfer successfully';
  }

  //Function for sender's amount to be transferred from account in the bank to other receiver's wallet 
  function sendEther(address payable toAddress , uint256 amount) public payable returns(string memory){
      require(amount>0, 'Enter non-zero value for withdrawal');
      require(userExists[msg.sender]==true, 'Account is not created');
      require(userAccount[msg.sender]>amount, 'insufficient balance in Bank account');
      userAccount[msg.sender]=userAccount[msg.sender]-amount;
      toAddress.transfer(amount);
      return 'transfer success';
  }

  function userAccountBalance() public view returns(uint){
      return userAccount[msg.sender];
  }
  
  function accountExist() public view returns(bool){
      return userExists[msg.sender];
  }

}
