buildPath := build
solidityPath := ../contracts/verifiers
testPath := ../test/circuits
circomlibPath := ../node_modules/circomlib/
chainId := 31337

.PHONY: install clean
install: verifier2.sol verifier2_final.zkey instance2_js/instance2.wasm verifier10.sol verifier10_final.zkey instance10_js/instance10.wasm  swapperM.sol
	cp ./verifier2.sol $(solidityPath)/Verifier2.sol
	cp ./verifier10.sol $(solidityPath)/Verifier10.sol

	cp ./swapperM.sol $(solidityPath)/swapperM.sol
	cp ./swapperM_final.zkey $(testPath)/swapperM_final.zkey
	cp ./swapperM_js/swapperM.wasm $(testPath)/swapperM.wasm

verifier2.sol: verifier2_final.zkey
	snarkjs zkey export solidityverifier verifier2_final.zkey verifier2.sol
	sed -i.bak 's/\^0.6.11/>=0.8.0/' ./verifier2.sol # change solidity compiler version from 0.6.11 to >=0.8.0, this allows us to use newer compilers and newer solidity libraries.
	sed -i.bak 's/Verifier/Verifier2/' ./verifier2.sol # change contract name
verifier2_final.zkey: verifier2_0000.zkey
	echo `LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c20` | snarkjs zkey contribute "verifier2_0000.zkey" "verifier2_final.zkey" --name="1st Contributor Name" -v
verifier2_0000.zkey: hez18.ptau instance2.r1cs
	snarkjs groth16 setup instance2.r1cs hez18.ptau verifier2_0000.zkey -v

verifier10.sol: verifier10_final.zkey
	snarkjs zkey export solidityverifier verifier10_final.zkey verifier10.sol
	sed -i.bak 's/\^0.6.11/>=0.8.0/' ./verifier10.sol # change solidity compiler version from 0.6.11 to >=0.8.0, this allows us to use newer compilers and newer solidity libraries.
	sed -i.bak 's/Verifier/Verifier10/' ./verifier10.sol # change contract name
verifier10_final.zkey: verifier10_0000.zkey
	echo `LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c20` | snarkjs zkey contribute "verifier10_0000.zkey" "verifier10_final.zkey" --name="1st Contributor Name" -v
verifier10_0000.zkey: hez18.ptau instance10.r1cs
	snarkjs groth16 setup instance10.r1cs hez18.ptau verifier10_0000.zkey -v

hez18.ptau:
	wget "https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_18.ptau" -O hez18.ptau

instance10_js/instance10.wasm: instance10.circom Verifier.circom ForbidDuplicates.circom MerkleRootCalculator.circom Signature.circom
	circom instance10.circom --r1cs --wasm -l $(circomlibPath)
instance10.r1cs: instance10_js/instance10.wasm
	@:

instance2_js/instance2.wasm: instance2.circom Verifier.circom ForbidDuplicates.circom MerkleRootCalculator.circom Signature.circom
	circom instance2.circom --r1cs --wasm -l $(circomlibPath)
instance2.r1cs: instance2_js/instance2.wasm
	@:


swapperM.sol: swapperM_final.zkey
	snarkjs zkey export solidityverifier swapperM_final.zkey swapperM.sol
	sed -i.bak 's/\^0.6.11/>=0.8.0/' ./swapperM.sol # change solidity compiler version from 0.6.11 to >=0.8.0, this allows us to use newer compilers and newer solidity libraries.
	sed -i.bak 's/Verifier/SwapperM/' ./swapperM.sol # change contract name
swapperM_final.zkey: swapperM_0000.zkey
	echo `LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c20` | snarkjs zkey contribute "swapperM_0000.zkey" "swapperM_final.zkey" --name="1st Contributor Name" -v
swapperM_0000.zkey: hez18.ptau swapperM.r1cs
	snarkjs groth16 setup swapperM.r1cs hez18.ptau swapperM_0000.zkey -v

swapperM.r1cs: swapperM.circom SwapperM.circom
	circom swapperM.circom --r1cs --wasm -l $(circomlibPath)

.PHONY: clean
clean:

	- rm ./verifier2.sol
	- rm ./verifier2.sol.bak
	- rm ./verifier2_final.zkey
	- rm ./verifier2_0000.zkey
	- rm -rf ./instance2_js/
	- rm ./instance2.r1cs

	- rm ./verifier10.sol
	- rm ./verifier10.sol.bak
	- rm ./verifier10_final.zkey
	- rm ./verifier10_0000.zkey
	- rm -rf ./instance10_js/
	- rm ./instance10.r1cs

	- rm ./swapperM.sol.bak
	- rm ./swapperM.sol.bak
	- rm ./swapperM.sol
	- rm ./swapperM_final.zkey
	- rm ./swapperM_0000.zkey
	- rm ./swapperM.r1cs
	- rm -rf ./swapper_js
