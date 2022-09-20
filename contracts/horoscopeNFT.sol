//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8769b19860863ed14e82ac78eb0d09449a49290b/contracts/token/ERC721/ERC721.sol"
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8769b19860863ed14e82ac78eb0d09449a49290b/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/8769b19860863ed14e82ac78eb0d09449a49290b/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./Base64.sol";

contract horoscopeNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

string baseSvg =
    "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

constructor() ERC721("Horoscope NFT", "HNFT") {}

function mintNFT(address recipient, string memory zodiacSign)
    public
    returns (uint256)
{
    _tokenIds.increment();

    string memory finalSvg = string(
        abi.encodePacked(baseSvg, zodiacSign, "</text></svg>")
    );

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',zodiacSign,
                    // Set the title of our NFT as the generated word.
                    '", "description": "On-chain Zodiac Sign NFTs", "attributes": [{"trait_type": "Zodiac Sign", "value": "',
                    zodiacSign,
                    '"}], "image": "data:image/svg+xml;base64,',
                    // Add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    // Prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    uint256 newItemId = _tokenIds.current();
    _mint(recipient, newItemId);
    _setTokenURI(newItemId, finalTokenUri);

    return newItemId;
    }
}
