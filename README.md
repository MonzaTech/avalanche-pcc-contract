# 🔗 Avalanche Proof Commitment Contract (PCC)

## Project Overview
The **Proof Commitment Contract (PCC)** is the central on-chain component of the Sentinel Grid data integrity layer. This Solidity contract is designed to be deployed on the **Avalanche C-Chain** (initially Fuji Testnet) or a dedicated **Avalanche Subnet**.

### Primary Role
The PCC serves as the immutable, highly available **Registry of Trust** for national critical infrastructure telemetry. It performs the following functions:
* **Root Registration:** Accepts the `Merkle Root` (the cryptographic proof) and the associated `Filecoin CID` (the data archive pointer) submitted by the off-chain engine.
* **Timestamping:** Records the commitment time and the submitter's address, providing the definitive, low-latency settlement anchor guaranteed by Avalanche's finality.
* **Query Interface:** Exposes functions for external auditors to query the integrity of specific data batches.

### Technical Specification
* **Language:** Solidity (EVM-compatible).
* **Target:** Avalanche C-Chain / Custom Subnets (for scaling).
* **Security:** Designed for minimal gas cost and maximal security (only stores hash references, not raw data).

### Status & Next Steps
We are currently finalizing the contract interfaces and preparing for external security review.
