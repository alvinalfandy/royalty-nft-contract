# 🚀 Kontrak NFT Royalti Minting

## 🔍 Ringkasan Proyek
Kontrak smart contract Solidity untuk minting NFT dengan mekanisme royalti terintegrasi di blockchain Ethereum.

## ✨ Fitur Utama
- Implementasi Standar ERC-721
- Harga Minting Tetap
- Distribusi Royalti (10%)
- Batasan Pasokan Maksimal (10.000 NFT)
- Fungsi Manajemen Pemilik

## 🛠 Spesifikasi Teknis
- **Versi Solidity**: ^0.8.20
- **Blockchain**: Ethereum
- **Standar Token**: ERC-721
- **Standar Royalti**: ERC-2981

## 📦 Detail Kontrak

### Mekanisme Minting
- Harga Mint: Dapat Dikonfigurasi
- Pasokan Maksimal: 10.000 NFT
- Royalti: 10% pada penjualan sekunder

### Kontrol Akses
- Pemilik dapat:
  - Menarik Dana Kontrak
  - Update Base URI
  - Sesuaikan Harga Mint

## 🔐 Fitur Keamanan
- Integrasi Pustaka OpenZeppelin
- Pembatasan Kepemilikan
- Validasi Harga Mint
- Perlindungan Batas Pasokan

## 💻 Instalasi

### Dependensi
- Hardhat
- Kontrak OpenZeppelin

```bash
npm install @openzeppelin/contracts
```

## 🚀 Deployment
1. Konfigurasikan parameter konstruktor
2. Atur base URI
3. Tentukan harga mint awal

