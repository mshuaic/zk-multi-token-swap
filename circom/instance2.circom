pragma circom 2.0.0;

include "./Verifier.circom";

component main {public [rootHashHinkal, rootHashAccessToken, publicAmount, erc20TokenAddress, recipientAddress,relay, relayFee, inNullifiers, outCommitments]} = Verifier(2,25);
