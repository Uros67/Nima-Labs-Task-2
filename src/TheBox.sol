// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TheBox {
    struct Element {
        uint256 id;
        string data;
        bool forSale;
        uint256 lastActivity;
        bool exists;
    }
    
    mapping(uint256 => Element) public elements;
    uint256[] public elementIds;
    uint256 public maxSize;
    uint256 public elementCount;
    uint256 private nextId;
    
    event ElementAdded(uint256 indexed id, string data);
    event ElementRemoved(uint256 indexed id);
    event ForSaleUpdated(uint256 indexed id, bool forSale);
    
    constructor(uint256 _maxSize) {
        maxSize = _maxSize;
        nextId = 1;
    }
    function addElement(string memory _data) external {
        require(bytes(_data).length > 0, "Data cannot be empty");
        if (elementCount >= maxSize) {
            _removeLeastActive();
        }
        
        uint256 id = nextId++;
        elements[id] = Element({
            id: id,
            data: _data,
            forSale: false,
            lastActivity: block.timestamp,
            exists: true
        });
        
        elementIds.push(id);
        elementCount++;
        
        emit ElementAdded(id, _data);
    }
    
    function removeElement(uint256 _id) external {
        require(elements[_id].exists, "Element does not exist");
        
        _removeElement(_id);
        emit ElementRemoved(_id);
    }
    
    function contains(uint256 _id) external view returns (bool) {
        return elements[_id].exists;
    }
    
    function markForSale(uint256 _id, bool _forSale) external {
        require(elements[_id].exists, "Element does not exist");
        
        elements[_id].forSale = _forSale;
        elements[_id].lastActivity = block.timestamp;
        
        emit ForSaleUpdated(_id, _forSale);
    }
    
    
    function getAllElements() external view returns (Element[] memory) {
        Element[] memory result = new Element[](elementCount);
        
        for (uint256 i = 0; i < elementIds.length; i++) {
            uint256 id = elementIds[i];
            if (elements[id].exists) {
                result[i] = elements[id];
            }
        }
        
        return result;
    }
    
    function _removeLeastActive() private {
        uint256 leastActiveId;
        uint256 oldestTimestamp = block.timestamp;
        for (uint256 i = 0; i < elementIds.length; i++) {
            uint256 id = elementIds[i];
            if (elements[id].exists && elements[id].lastActivity < oldestTimestamp) {
                oldestTimestamp = elements[id].lastActivity;
                leastActiveId = id;
            }
        }
        
        if (leastActiveId != 0) {
            _removeElement(leastActiveId);
        }
    }

    function _removeElement(uint256 _id) private {
        delete elements[_id];
        elementCount--;
        
        // Note: We don't remove from elementIds array to maintain iteration order
        // The exists flag handles the logical removal
    }
    
    function getElementCount() external view returns (uint256) {
        return elementCount;
    }
    
    function getMaxSize() external view returns (uint256) {
        return maxSize;
    }
    
    function isFull() external view returns (bool) {
        return elementCount >= maxSize;
    }
}