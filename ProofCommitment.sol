// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Sentinel Grid Proof Commitment Contract (PCC)
 * @dev Registry for verifying infrastructure telemetry integrity on Avalanche.
 */
contract SentinelGridPCC {
    
    // Event emitted when a new proof is committed. 
    // Indexers (The Graph/Subquery) listen for this.
    event ProofCommitted(
        bytes32 indexed merkleRoot, 
        string ipfsCid, 
        uint256 timestamp, 
        address indexed committer
    );

    struct Commitment {
        string ipfsCid;
        uint256 timestamp;
        address committer;
        bool exists;
    }

    // Mapping from Merkle Root -> Commitment Details
    mapping(bytes32 => Commitment) public commitments;
    
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Commits a telemetry batch proof to the chain.
     * @param _merkleRoot The cryptographic root of the telemetry batch.
     * @param _ipfsCid The IPFS Content Identifier for the raw data archive.
     */
    function commitProof(bytes32 _merkleRoot, string calldata _ipfsCid) external {
        require(!commitments[_merkleRoot].exists, "Proof already exists.");

        commitments[_merkleRoot] = Commitment({
            ipfsCid: _ipfsCid,
            timestamp: block.timestamp,
            committer: msg.sender,
            exists: true
        });

        emit ProofCommitted(_merkleRoot, _ipfsCid, block.timestamp, msg.sender);
    }

    /**
     * @notice Verifies if a root exists and returns the IPFS CID.
     */
    function verifyProof(bytes32 _merkleRoot) external view returns (bool exists, string memory ipfsCid, uint256 timestamp) {
        Commitment memory c = commitments[_merkleRoot];
        return (c.exists, c.ipfsCid, c.timestamp);
    }
}
