pragma circom 2.1.5;

include "./SwapperM.circom";

component main {public [rootHash,
                        inErc20TokenAddresses,
                        inNullifiers,
                        inSwapAmounts,
                        outErc20TokenAddresses,
                        outSwapAmounts,
                        outCommitments,
                        rootHashAccessToken,
                        fee,
                        relay,
                        relayFee]} = Swapper(6,2,6,25);
