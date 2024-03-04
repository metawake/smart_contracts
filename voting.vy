# Define the Vyper version to be used
# vyper>=0.2.0-beta.14,<0.3.0
# Define the voting contract
# Keep track of candidates and votes
# Allows voting and keeps track of the winner

# Define the voting contract
contract Voting:
    # Initialize the contract with a list of candidates
    candidates: public({})

    # Initialize the contract with a list of candidates
    votes: public(map(address, uint256))

    # Initialize the contract with a list of candidates
    winner: public(address)

    # Set up the initial list of candidates
    def __init__(_candidates: address[3]):
        self.candidates = {
            _candidates[0]: 0,
            _candidates[1]: 0,
            _candidates[2]: 0
        }

    # Function to cast a vote for a candidate
    def vote(self, _candidate: address):
        # Ensure the candidate is valid
        assert _candidate in self.candidates

        # Increment the vote count for the chosen candidate
        self.votes[_candidate] += 1

    # Function to get the total votes for a candidate
    def total_votes_for(self, _candidate: address) -> uint256:
        return self.votes[_candidate]

    # Function to determine the winner
    def get_winner(self) -> address:
        # Initialize the winner with the first candidate
        self.winner = list(self.candidates.keys())[0]

        # Loop through all candidates to find the one with the most votes
        for candidate in self.candidates:
            if self.votes[candidate] > self.votes[self.winner]:
                self.winner = candidate

        return self.winner
