export const abi =  [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "newGoverner",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "Governer_ID",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "Addedby",
          "type": "address"
        }
      ],
      "name": "GovernerAdded",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "Governer",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "CompanyAccount",
          "type": "address"
        }
      ],
      "name": "companyRegistrationApproved",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "Owner",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "Name",
          "type": "string"
        }
      ],
      "name": "companyRegistrationRequested",
      "type": "event"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "name": "GovernerAddresses",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_newGoverner",
          "type": "address"
        },
        {
          "internalType": "string",
          "name": "_Name",
          "type": "string"
        }
      ],
      "name": "addGoverner",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": true
    },
    {
      "inputs": [],
      "name": "getGoverners",
      "outputs": [
        {
          "internalType": "address[]",
          "name": "",
          "type": "address[]"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_addr",
          "type": "address"
        }
      ],
      "name": "isGoverner",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "_Name",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "_totalStocks",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_stockPrice",
          "type": "uint256"
        }
      ],
      "name": "requestRegisterMyCompany",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_CpnyAddr",
          "type": "address"
        }
      ],
      "name": "approveCompany",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": true
    },
    {
      "inputs": [],
      "name": "getAllCompanies",
      "outputs": [
        {
          "internalType": "address[]",
          "name": "",
          "type": "address[]"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_CpnyAddr",
          "type": "address"
        }
      ],
      "name": "isCompanyRegistered",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "_CpnyAddr",
          "type": "address"
        }
      ],
      "name": "isCompanyApproved",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    }
  ]