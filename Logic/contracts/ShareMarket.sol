pragma solidity 0.8.7;

import "./Governable.sol";
import "./CompaniesContract.sol";

/// @title shareholder info
/// @author aliimran2000
contract ShareMarket is Governable("Contract Deployer") {
    event companyRegistrationRequested(address indexed Owner, string Name);
    event companyRegistrationApproved(
        address indexed Governer,
        address indexed CompanyAccount
    );

    uint256 CompanyCreationCost = 10;

    CompaniesContract private _Companies;

    
    constructor() {
        _Companies = new CompaniesContract();
    }

    //res = await Contract.methods.requestRegisterMyCompany("Acme",100,1234).send({from:accounts[2],'gas':'1000000'})
    function requestRegisterMyCompany(
        string memory _Name,
        uint256 _totalStocks,
        uint256 _stockPrice
    ) public payable {
        //require(msg.value >= 0);
        _Companies._requestRegisterMyCompany(
            msg.sender,
            _Name,
            _totalStocks,
            _stockPrice
        );
        emit companyRegistrationRequested(msg.sender, _Name);
    }

    function approveCompany(address _CpnyAddr) public payable onlyGoverner {
        //require(msg.value >= 0);
        _Companies._approveCompany(_CpnyAddr);
        emit companyRegistrationApproved(msg.sender, _CpnyAddr);
    }

    function getAllCompanies() public view returns (address[] memory) {
        return _Companies.getAllCompanies();
    }

    function isCompanyRegistered(address _CpnyAddr) public view returns (bool) {
        return _Companies.isRegistered(_CpnyAddr);
    }

    function isCompanyApproved(address _CpnyAddr) public view returns (bool) {
        return _Companies.isApproved(_CpnyAddr);
    }
}
