pragma circom 2.0.0;

include "./Swapper.circom";

component main {public [rootHashHinkal, rootHashAccessToken, inSwapAmount, outSwapAmount, inErc20TokenAddress, outErc20TokenAddress,fee, relay, relayFee, inNullifiers, outCommitments ]} = Swapper(10,25);
