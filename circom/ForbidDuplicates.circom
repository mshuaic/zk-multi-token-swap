pragma circom 2.0.0;

template ForbidDuplicates(inputCount) {
	signal input list[inputCount];
	component calcEqual[(inputCount * (inputCount - 1)) / 2];
	var pointer = 0;
	for (var i = 0; i < inputCount - 1; i++) {
		for (var j = i + 1; j < inputCount; j++) {
			calcEqual[pointer] = IsEqual();
			calcEqual[pointer].in[0] <== list[i];
			calcEqual[pointer].in[1] <== list[j];
			calcEqual[pointer].out === 0;
			pointer++;
		}
	}
}