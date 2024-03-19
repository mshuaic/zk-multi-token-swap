import { MerkleTreeIncompleteError } from './MerkleTreeIncompleteError';

export type MerkleTreeJson = {
  tree: Record<string, string>;
  count: string;
  index: string;
};

/**
 * Merkle tree implementation that allows the user to insert in specific places in the tree
 *
 */
export class MerkleTree<T> {
  /**
   * the map where the items are stored
   */
  private readonly tree;

  /**
   * amount of elements inserted inside the bottom row of the tree
   */
  private count: bigint;

  /**
   * the maximum index inserted into the tree
   * used together with count to make sure that the merkle tree is complete.
   * meaning that there aren't any missing elements between getStartIndex() and index
   */
  private index: bigint;

  public static createWithData<T>(
    tree: Map<bigint, T>,
    index: bigint,
    count: bigint,
    hashFunction: (a: T, b: T) => T,
    levels: bigint,
    defaultNodeValue: T,
  ): MerkleTree<T> {
    const merkleTree = new MerkleTree(hashFunction, levels, defaultNodeValue, tree, index, count);
    merkleTree.completenessCheck();
    return merkleTree;
  }

  /**
   * @param hashFunction the hashFunction used to fill the upper layers of the merkle tree
   * @param levels the amount of layers in the merkle tree
   * @param defaultNodeValue the default value of an empty node in the merkle tree
   */
  public static create<T>(hashFunction: (a: T, b: T) => T, levels: bigint, defaultNodeValue: T): MerkleTree<T> {
    return new MerkleTree(hashFunction, levels, defaultNodeValue);
  }

  private constructor(
    private hashFunction: (a: T, b: T) => T,
    private levels: bigint,
    private defaultNodeValue: T,
    tree?: Map<bigint, T>,
    index?: bigint,
    count?: bigint,
  ) {
    this.tree = tree ?? new Map<bigint, T>();
    this.count = count ?? 0n;
    this.index = index ?? 2n ** (levels - 1n);
  }

  /**
   * get starting nodeIndex from which inserts are allowed
   */
  public getStartIndex() {
    return 2n ** (this.levels - 1n);
  }

  /**
   * implementation of logarithm2 function from merkle contract
   */
  logarithm2(a: bigint) {
    let i = 0n;
    while (2n ** i < a) i += 1n;
    return i;
  }

  bigIntMax(a: bigint, b: bigint) {
    return a > b ? a : b;
  }

  /**
   * insert value into the merkle tree
   * @param value the value to insert
   * @param nodeIndex the index to insert the value, you can get starting index from getStartIndex()
   * @return true - if added, false - if already exists
   * @throws will throw RangeError if nodeIndex is less than getStartIndex()
   */
  insert(value: T, nodeIndex: bigint): boolean {
    if (nodeIndex < this.getStartIndex()) {
      throw new RangeError();
    }

    if (this.tree.has(nodeIndex)) {
      return false;
    }

    this.count += 1n;
    this.tree.set(nodeIndex, value);
    this.index = this.bigIntMax(nodeIndex + 1n, this.index); // if nodeIndex = index => increment index
    const fullCount = this.index - this.getStartIndex();
    const twoPower = this.logarithm2(fullCount);
    let currentNodeIndex = nodeIndex;
    for (let i = 1n; i <= twoPower; i += 1n) {
      currentNodeIndex /= 2n;
      const result = this.hashFunction(
        this.tree.get(currentNodeIndex * 2n) || this.defaultNodeValue,
        this.tree.get(currentNodeIndex * 2n + 1n) || this.defaultNodeValue,
      );
      this.tree.set(currentNodeIndex, result);
    }
    return true;
  }

  private completenessCheck() {
    if (this.count !== this.index - this.getStartIndex()) {
      throw new MerkleTreeIncompleteError();
    }
  }

  /**
   * get root hash of the merkle tree
   * @returns the hash, if the merkle tree is empty, will return
   * @throws will throw MerkleTreeIncompleteError if there are missing elements in the tree
   */
  getRootHash() {
    this.completenessCheck();
    for (let i = 1n; i < 2n ** this.levels; i *= 2n) {
      if (this.tree.get(i)) {
        return this.tree.get(i);
      }
    }
    return this.defaultNodeValue;
  }

  getMerkleData() {
    this.completenessCheck();
    return new Map<bigint, T>(this.tree);
  }

  getSiblingIndex(index: bigint) {
    if (index === 1n) return 1n;
    return index % 2n === 1n ? index - 1n : index + 1n;
  }

  /**
   * get sibling hashes needed by main.circom
   * @throws will throw MerkleTreeIncompleteError if there are missing elements in the tree
   */
  getSiblingHashesForVerification(item: T) {
    this.completenessCheck();
    let index;

    for (let i = this.getStartIndex(); i < this.getStartIndex() + this.index; i += 1n) {
      if (this.tree.get(i) === item) {
        index = i;
        break;
      }
    }

    if (index === undefined) return new Array<bigint>(Number(this.levels)).fill(0n);

    const hashes: T[] = [];

    while (index !== 0n) {
      hashes.push(this.tree.get(this.getSiblingIndex(index)) || this.defaultNodeValue);
      index /= 2n;
    }
    return hashes;
  }

  /**
   * get item's sibling hashes side
   * @returns sibling's indexes
   * @throws will throw MerkleTreeIncompleteError if there are missing elements in the tree
   */
  getSiblingSides(item: T) {
    this.completenessCheck();
    let index;

    for (let i = this.getStartIndex(); i < this.getStartIndex() + this.index; i += 1n) {
      if (this.tree.get(i) === item) {
        index = i;
        break;
      }
    }

    if (index === undefined) return new Array<bigint>(Number(this.levels)).fill(0n);

    const siblingSides: bigint[] = [];

    while (index !== 0n) {
      const value = index % 2n === 0n ? 0n : 1n; // left = 0, right = 1
      siblingSides.push(value);
      index /= 2n;
    }
    return siblingSides;
  }

  public toJSON(): MerkleTreeJson {
    const { tree, count, index } = this;
    return {
      tree: Object.fromEntries(tree),
      count: count.toString(),
      index: index.toString(),
    };
  }
}
