export class MerkleTreeIncompleteError extends Error {
  constructor() {
    super('Merkle tree is incomplete');
    this.name = 'MerkleTreeIncompleteError';
  }
}
