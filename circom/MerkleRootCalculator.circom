pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/switcher.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib/circuits/poseidon.circom";

template MerkleRootCalculator(inputs) {
	signal input inCommitment;
	signal input commitmentSiblings[inputs]; // commitment siblings needed to verify merkle tree
	signal input commitmentSiblingSides[inputs]; // left -> 0; right -> 1;
	signal output rootHash;

	component switcher[inputs];
    component hasher[inputs];
    component commitmentSiblingIsZero[inputs];

	signal hashes[inputs+1];
	signal hashesProcessed[inputs];

	hashes[0] <== inCommitment;

 	for (var i = 0; i < inputs; i++) {
		switcher[i] = Switcher();
		switcher[i].L <== hashes[i];
		switcher[i].R <== commitmentSiblings[i];
		switcher[i].sel <== commitmentSiblingSides[i];
		hasher[i] = Poseidon(2);
		hasher[i].inputs[0] <== switcher[i].outL;
		hasher[i].inputs[1] <== switcher[i].outR;
		hashes[i+1] <== hasher[i].out;

		commitmentSiblingIsZero[i] = IsZero();
		commitmentSiblingIsZero[i].in <== commitmentSiblings[i];
		hashesProcessed[i] <== hashes[i+1] * (1 - commitmentSiblingIsZero[i].out); //  0 if sibling = 0 , and next hash if  sibling != 0
	}

	signal rootHashes[inputs+1];
	component hashesProcessedIsZero[inputs+1];
	rootHashes[0] <== hashes[0];

	for (var i = 1; i < inputs+1; i++) {
		hashesProcessedIsZero[i] = IsZero();
		hashesProcessedIsZero[i].in <== hashesProcessed[i - 1];
		rootHashes[i] <== hashesProcessed[i - 1] + hashesProcessedIsZero[i].out * rootHashes[i - 1];
        // previous roothash if previous hashProcessed = 0, or previous hashProcessed if previous hashprocessed != 0
        // hash = previous hash if current sibling is zero , current next hash if sibling is not zero
	}

	rootHash <== rootHashes[inputs];
}
