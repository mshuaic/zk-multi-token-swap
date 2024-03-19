pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/bitify.circom";
include "./ForbidDuplicates.circom";
include "./MerkleRootCalculator.circom";
include "./Signature.circom";

template Verifier(inputCount, treeDepth) {
	signal input rootHashHinkal; // root hash of the merkle tree

	signal input shieldedPrivateKey; // shielded private key of the sender
	signal input publicAmount; // public amount going in/out of the contract
	signal input recipientAddress;

	signal input inAmounts[inputCount]; // should be zero when depositing
	signal input inBlindings[inputCount]; // blinding used to hide amount, and make depositing same amounts possible
	signal input erc20TokenAddress;
	signal input inNullifiers[inputCount];
	signal input inCommitmentSiblings[inputCount][treeDepth];
	signal input inCommitmentSiblingSides[inputCount][treeDepth]; // left = 0, right = 1

	signal input outAmounts[2]; // output Amount
	signal input outBlindings[2]; // output blinding;
	signal input outShieldedPublicKey[2]; // pubkey of the receiver and change
	signal input outCommitments[2];


	signal input rootHashAccessToken;
	signal input accessTokenSiblings[treeDepth];
	signal input accessTokenSiblingSides[treeDepth];

    signal input relay;
	signal input relayFee;

	// calculate public key of the sender;
	component publicKeyCalculator = Poseidon(1);
	publicKeyCalculator.inputs[0] <== shieldedPrivateKey;
	signal publicKey <== publicKeyCalculator.out;

	component calcCommitment[inputCount];
	component calcSignature[inputCount];
	component calcNullifier[inputCount];
	component calcTransactionRootHash[inputCount];
	component calcEqual[inputCount];

	var inTotal = 0;

	for (var i = 0; i < inputCount; i++) {
		// 1) Calculating Commitments for Input UTXO
		calcCommitment[i] = Poseidon(4);
		calcCommitment[i].inputs[0] <== inAmounts[i];
		calcCommitment[i].inputs[1] <== erc20TokenAddress;
		calcCommitment[i].inputs[2] <== publicKey; // since public key is derived from private, ownership of comitment is prooved
		calcCommitment[i].inputs[3] <== inBlindings[i];

		// 2) Calculating Signature for Nullifier:
		// signature is included in nullifier in order for only owner to know hash it nullifies
		calcSignature[i] = Signature();
		calcSignature[i].shieldedPrivateKey <== shieldedPrivateKey;
		calcSignature[i].commitment <== calcCommitment[i].out;

		// 3) Calculating Nullifier from commitment and signature
		calcNullifier[i] = Poseidon(2);
		calcNullifier[i].inputs[0] <== calcCommitment[i].out;
		calcNullifier[i].inputs[1] <== calcSignature[i].out;

		// 4) Checking that nullifier is legit
		inNullifiers[i] === calcNullifier[i].out;

		calcTransactionRootHash[i] = MerkleRootCalculator(treeDepth);
		calcTransactionRootHash[i].inCommitment <== calcCommitment[i].out;
		for (var j = 0; j < treeDepth; j++) {
			calcTransactionRootHash[i].commitmentSiblings[j] <== inCommitmentSiblings[i][j];
			calcTransactionRootHash[i].commitmentSiblingSides[j] <== inCommitmentSiblingSides[i][j];
		}

		calcEqual[i] = ForceEqualIfEnabled();
		calcEqual[i].in[0] <== calcTransactionRootHash[i].rootHash;
		calcEqual[i].in[1] <== rootHashHinkal;
		calcEqual[i].enabled <== inAmounts[i];
		inTotal += inAmounts[i];
	}

	component calcOutCommitment[2];
	component calcOutBits[2];

	var outTotal = 0;

	for (var i = 0; i < 2; i++) {

		calcOutCommitment[i] = Poseidon(4);
		calcOutCommitment[i].inputs[0] <== outAmounts[i]; // if outAmount is negative, than this line will throw error
		calcOutCommitment[i].inputs[1] <== erc20TokenAddress;
		calcOutCommitment[i].inputs[2] <== outShieldedPublicKey[i];
		calcOutCommitment[i].inputs[3] <== outBlindings[i];

		// Checking that output commitment is legit
		calcOutCommitment[i].out === outCommitments[i];

		calcOutBits[i] = Num2Bits(128);
		calcOutBits[i].in <== outAmounts[i]; // this will check if outAmounts[i] fits into 128 bits, this will also check that output amounts aren't negative
		outTotal += outAmounts[i];
	}

	// Final double spending prevention constraint
	outTotal === inTotal + publicAmount;

	component calcAccessToken = Poseidon(2);
	calcAccessToken.inputs[0] <== shieldedPrivateKey;
	calcAccessToken.inputs[1] <== publicKey;

	component calcAccessRootHash = MerkleRootCalculator(treeDepth);
	calcAccessRootHash.inCommitment <== calcAccessToken.out;

	for (var i = 0; i < treeDepth; i++) {
		calcAccessRootHash.commitmentSiblings[i] <== accessTokenSiblings[i];
		calcAccessRootHash.commitmentSiblingSides[i] <== accessTokenSiblingSides[i];
	}

	calcAccessRootHash.rootHash === rootHashAccessToken;
}
