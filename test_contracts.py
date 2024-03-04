# Import the contract object from the brownie package
from brownie import Voting, accounts

# Define a test case
def test_voting():
    # Deploy the Voting contract
    voting_contract = Voting.deploy([accounts[0], accounts[1], accounts[2]], {'from': accounts[0]})
    
    # Cast votes
    voting_contract.vote(accounts[0], {'from': accounts[0]})
    voting_contract.vote(accounts[1], {'from': accounts[1]})
    voting_contract.vote(accounts[1], {'from': accounts[2]})

    # Check the total votes for a candidate
    assert voting_contract.total_votes_for(accounts[0]) == 1
    assert voting_contract.total_votes_for(accounts[1]) == 2

    # Check the winner
    assert voting_contract.get_winner() == accounts[1]
