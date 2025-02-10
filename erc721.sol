// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RoyaltyNFT is ERC721Royalty, Ownable {
    // Gunakan Counter untuk melacak token ID
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Variabel untuk menyimpan base URI metadata token
    string private _baseTokenURI;

    // Harga mint per NFT
    uint256 public mintPrice;

    // Batas maksimum jumlah NFT yang dapat di-mint
    // Total supply maksimum adalah 10.000 NFT
    uint256 public constant MAX_SUPPLY = 10000;

    // Persentase royalti untuk penjualan ulang 
    // 1000 = 10% dari harga jual sekunder
    uint96 public constant ROYALTY_PERCENTAGE = 1000;

    // Constructor untuk inisialisasi kontrak
    // Parameter:
    // - name: Nama koleksi NFT
    // - symbol: Simbol token
    // - baseURI: Lokasi metadata token
    // - _mintPrice: Harga untuk minting satu NFT
    constructor(
        string memory name, 
        string memory symbol, 
        string memory baseURI,
        uint256 _mintPrice
    ) ERC721(name, symbol) {
        _baseTokenURI = baseURI;
        mintPrice = _mintPrice;
    }

    // Fungsi untuk minting NFT baru
    // Memastikan pembayaran cukup dan belum mencapai batas maksimum
    function mint() public payable {
        // Cek apakah pembayaran mencukupi
        require(msg.value >= mintPrice, "Pembayaran tidak mencukupi");
        
        // Cek apakah belum mencapai batas maksimum supply
        require(_tokenIds.current() < MAX_SUPPLY, "Supply NFT sudah penuh");

        // Naikkan counter token ID
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        // Mint token ke alamat pengirim
        // Atur royalti untuk token yang baru di-mint
        _safeMint(msg.sender, newTokenId);
        _setTokenRoyalty(newTokenId, msg.sender, ROYALTY_PERCENTAGE);
    }

    // Fungsi untuk penarikan dana kontrak
    // Hanya dapat diakses oleh pemilik kontrak
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    // Override fungsi base URI untuk metadata
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    // Update base URI metadata (hanya oleh pemilik)
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _baseTokenURI = newBaseURI;
    }

    // Update harga mint (hanya oleh pemilik)
    function setMintPrice(uint256 newPrice) public onlyOwner {
        mintPrice = newPrice;
    }

    // Implementasi dukungan interface untuk royalti
    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        virtual 
        override(ERC721Royalty) 
        returns (bool) 
    {
        return super.supportsInterface(interfaceId);
    }
}
