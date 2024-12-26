# VeArtProxy
**Inherits:**
Ownable

Generates metadata and SVG images for veSIX NFTs based on lock data.


## State Variables
### veSix
The contract address of the IVeSix instance.


```solidity
IVeSix public immutable veSix;
```


## Functions
### constructor

Initializes the contract.


```solidity
constructor(address _veSix) Ownable(msg.sender);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_veSix`|`address`|The address of the IVeSix contract.|


### tokenURI

Generates the metadata URI for a given token.


```solidity
function tokenURI(uint256 tokenId) external view returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The ID of the token.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|A metadata URI string in Base64-encoded JSON format.|


### _getLockData

Retrieves lock data for a given token ID.

*Reverts if the token ID is invalid or has no associated lock data.*


```solidity
function _getLockData(uint256 tokenId) internal view returns (LockData memory data);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The ID of the token.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`data`|`LockData`|The lock data associated with the token ID.|


### _generateMetadata

Generates metadata for a token as a JSON string.


```solidity
function _generateMetadata(LockData memory data, string memory image) public pure returns (string memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`LockData`|The lock data of the token.|
|`image`|`string`|The SVG image string for the token.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|A JSON string containing the metadata.|


### generateSVG

Generates an SVG image for a token.


```solidity
function generateSVG(LockData memory data) internal view returns (string memory output);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`LockData`|The lock data of the token.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`output`|`string`|The SVG image as a string.|


### generateStringData

Generates string data for an SVG representation.


```solidity
function generateStringData(LockData memory data)
    internal
    view
    returns (string memory tokenId, string memory amount, string memory power, string memory date);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`data`|`LockData`|The lock data of the token.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`string`|The string representation of the token ID.|
|`amount`|`string`|The string representation of the lock amount.|
|`power`|`string`|The string representation of the multiplier.|
|`date`|`string`|The formatted lock end date or "Expired".|


### toString


```solidity
function toString(uint256 value) internal pure returns (string memory);
```

### decimalString


```solidity
function decimalString(uint256 number, uint8 decimals, bool isPercent) private pure returns (string memory);
```

### generateDecimalString


```solidity
function generateDecimalString(DecimalStringParams memory params) private pure returns (string memory);
```

## Errors
### InvalidTokenId
Error raised when the token ID is invalid (e.g., not associated with a lock).


```solidity
error InvalidTokenId();
```

### ZeroAddress
Error raised when a zero address is provided where it's not allowed.


```solidity
error ZeroAddress();
```

## Structs
### LockData
*Represents the lock data associated with a specific NFT.*


```solidity
struct LockData {
    uint256 tokenId;
    uint128 amount;
    uint128 slope;
    uint32 endTime;
    uint32 lastUpdate;
    uint128 multiplier;
}
```

### DecimalStringParams

```solidity
struct DecimalStringParams {
    uint256 sigfigs;
    uint8 bufferLength;
    uint8 sigfigIndex;
    uint8 decimalIndex;
    uint8 zerosStartIndex;
    uint8 zerosEndIndex;
    bool isLessThanOne;
    bool isPercent;
}
```

