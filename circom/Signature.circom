pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";

template Signature() {
    signal input shieldedPrivateKey;
    signal input commitment;
    //signal input merklePath;
    signal output out;

    component hasher = Poseidon(2);
    hasher.inputs[0] <== shieldedPrivateKey;
    hasher.inputs[1] <== commitment;
    out <== hasher.out;
}
