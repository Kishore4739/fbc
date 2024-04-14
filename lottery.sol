//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract PRlottery {
address public manager; // Address of the manager who deploys the contract
address[] public players; // Array to store addresses of participating players
address payable public winner; // Address of the winner who will receive the prize
constructor() {
manager = msg.sender; // Set the manager as the address that deploys the contract
}
// Function for players to participate in the lottery by sending ethers
function participate() public payable {
require(msg.value > 0.01 ether, "Minimum participation fee is 0.01 ether"); // Require players to
send at least 0.01 ether
players.push(payable(msg.sender)); // Add the player's address to the players array
}
// Function to get the current balance of the contract
function getBalance() public view returns(uint) {
require(manager == msg.sender, "You are not allowed to view the balance"); // Only the manager
can view the balance
return address(this).balance; // Return the contract's balance
}
// Function to generate a random number based on block timestamp and players' addresses
function random() public view returns(uint) {
return uint(keccak256(abi.encode(block.timestamp, players))); // Generate a random number
using block timestamp and players' addresses
}
// Function to pick a winner from the list of players
function pickWinner() public {
require(msg.sender == manager, "Only the manager can pick the winner"); // Only the manager
can pick the winner
require(players.length >= 3, "At least 3 players required to pick a winner"); // Require at least 3
players to pick a winner
uint r = random(); // Generate a random number
uint index = r % players.length; // Calculate the index of the winner based on the random number
winner = payable(players[index]); // Set the winner as the player at the calculated index
winner.transfer(getBalance()); // Transfer the entire balance of the contract to the winner
players = new address ; // Reset the players array to empty for the next round of lottery
}
}
