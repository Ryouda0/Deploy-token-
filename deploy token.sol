// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EcoLabsProject {
    string public projectName;
    uint256 public goalAmount;
    address public owner;
    bool public isProjectActive;

    constructor(string memory _name, uint256 _goal) {
        projectName = _name;
        goalAmount = _goal;
        owner = msg.sender;
        isProjectActive = true;
    }

    function donasi() public payable {
        require(isProjectActive, "Project sudah tutup!");
        require(msg.value > 0, "Kirim uang lebih dari 0!");
    }

    // Menangani kiriman uang murni (tanpa data)
    receive() external payable {
        donasi();
    }

    // Menangani jika ada data transaksi yang salah (agar tidak muncul error fallback mentah)
    fallback() external payable {
        donasi();
    }

    function nonaktifkanProject() public {
        require(msg.sender == owner, "Hanya pemilik!");
        isProjectActive = false;
    }

    function cekSaldoKontrak() public view returns (uint256) {
        return address(this).balance;
    }
}