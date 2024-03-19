import { MerkleTree } from './MerkleTree';
import { MerkleTreeIncompleteError } from './MerkleTreeIncompleteError';

const testHashFunction = (a: string, b: string) => JSON.stringify([a, b]);

describe('MerkleTree', () => {
  test('should calculate root hash for 2 elements correctly', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 2n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex);
    merkleTree.insert('b', startIndex + 1n);

    expect(merkleTree.getRootHash()).toEqual(testHashFunction('a', 'b'));
  });

  test('should calculate root hash for multiple elements correctly', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 3n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex);
    merkleTree.insert('b', startIndex + 1n);
    merkleTree.insert('c', startIndex + 2n);
    merkleTree.insert('d', startIndex + 3n);

    expect(merkleTree.getRootHash()).toEqual(testHashFunction(testHashFunction('a', 'b'), testHashFunction('c', 'd')));
  });

  test('should calculate root hash correctly if elements are passed out of order', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 3n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('d', startIndex + 3n);
    merkleTree.insert('c', startIndex + 2n);
    merkleTree.insert('b', startIndex + 1n);
    merkleTree.insert('a', startIndex);

    expect(merkleTree.getRootHash()).toEqual(testHashFunction(testHashFunction('a', 'b'), testHashFunction('c', 'd')));
  });

  test('should throw when getting root hash if it is incomplete', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 3n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex + 1n);
    expect(() => merkleTree.getRootHash()).toThrow(MerkleTreeIncompleteError);
  });

  test('should throw when getting underlying data if it is incomplete', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 3n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex + 1n);
    expect(() => merkleTree.getRootHash()).toThrow(MerkleTreeIncompleteError);
  });

  test("should return sibling's side indexes", async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 20n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex);
    merkleTree.insert('b', startIndex + 1n);
    merkleTree.insert('c', startIndex + 2n);
    merkleTree.insert('d', startIndex + 3n);
    merkleTree.insert('e', startIndex + 4n);

    expect(merkleTree.getSiblingSides('a')[0]).toEqual(0n);
    expect(merkleTree.getSiblingSides('d')[0]).toEqual(1n);
  });

  test('should work with large indexes', async () => {
    const merkleTree = MerkleTree.create(testHashFunction, 20n, '');
    const startIndex = merkleTree.getStartIndex();
    merkleTree.insert('a', startIndex);
    let lastRootHash = merkleTree.getRootHash();
    for (let i = 1n; i < 1000n; i += 1n) {
      merkleTree.insert('a', startIndex + i);
      const rootHash = merkleTree.getRootHash();
      expect(rootHash).not.toEqual(lastRootHash);
      lastRootHash = rootHash;
    }
  });
});
