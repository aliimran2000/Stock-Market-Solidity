pragma solidity 0.8.7;

import "./Governable.sol";
import "./CompaniesContract.sol";
import "./StockToken.sol";

//words share and stock are used interchangebly across the project
/// @title Main ShareMArket Cotnract Storage of Shares for each user and main finctions are done here 
/// @author github.com/aliimran2000
/// @dev Add more functionaliities here to make share market better 
contract ShareMarket is Governable("Contract Deployer"), StockToken(1000000) {
    event companyRegistrationRequested(address indexed Owner, string Name);
    event companyRegistrationApproved(
        address indexed Governer,
        address indexed CompanyAccount
    );

    event StockPostForSale(
        address seller,
        address company,
        uint256 numofStocks,
        uint256 Price
    );
    event StockPurchase(
        address buyer,
        address seller,
        address company,
        uint256 numofStocks,
        uint256 cost
    );

    uint256 CompanyCreationCost = 450; //STT
    uint256 GovernerApprovalFee = 50; //STT
    uint256 PostStockFee = 5; //STT
    uint256 removeStockFromMarket = 1; //STT

    struct SalePost {
        address Company;
        address Seller;
        uint256 numberofShares;
        uint256 price;
    }

    mapping(uint256 => SalePost) SalePosts;
    uint256 private SaleID = 0;

    function getNewSaleID() internal returns (uint256) {
        if (uint256(SaleID) >= 99999999999) {
            SaleID = 0;
        }
        SaleID++;
        return SaleID;
    }

    mapping(address => mapping(address => uint256)) ShareDetailsMap;

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

    function getStockPrice(address _CpnyAddr) public view returns (uint256) {
        return _Companies.getStockPrice(_CpnyAddr);
    }

    function buyStockFromCompany(address _CpnyAddr, uint256 numOfStocks)
        public
        payable
    {
        require(isCompanyApproved(_CpnyAddr) == true, "Company not approved");
        uint256 rate = getStockPrice(_CpnyAddr);
        uint256 cost = rate * numOfStocks;
        uint256 paymentWei = msg.value;
        uint256 paymentSTT = (paymentWei * conversionRate) / (10**18);
        require(paymentSTT >= cost, "Not enough STT");
        _transfer(msg.sender, _CpnyAddr, paymentSTT);
        _Companies.reduceStock(_CpnyAddr, numOfStocks);

        ShareDetailsMap[msg.sender][_CpnyAddr] += numOfStocks;

        emit StockPurchase(
            msg.sender,
            _CpnyAddr,
            _CpnyAddr,
            numOfStocks,
            paymentSTT
        );
    }

    function postStocksforSale(
        address _CpnyAddr,
        uint256 numberofShares,
        uint256 Price
    ) public payable returns (uint256) {
        uint256 saleID = getNewSaleID();
        SalePosts[saleID] = SalePost({
            Company: _CpnyAddr,
            Seller: msg.sender,
            numberofShares: numberofShares,
            price: Price
        });

        emit StockPostForSale(msg.sender, _CpnyAddr, numberofShares, Price);
        return saleID;
    }

    function buyPostedStock(uint256 _saleID) public payable {
        require(SalePosts[_saleID].numberofShares > 0, "Post not found");
        SalePost memory SP = SalePosts[_saleID];

        uint256 cost = SP.price;
        uint256 paymentWei = msg.value;
        uint256 paymentSTT = (paymentWei * conversionRate) / (10**18);
        require(paymentSTT >= cost, "Not enough STT");

        _transfer(msg.sender, SP.Seller, paymentSTT);

        ShareDetailsMap[SP.Seller][SP.Company] -= SP.numberofShares;
        ShareDetailsMap[msg.sender][SP.Company] += SP.numberofShares;

        emit StockPurchase(
            msg.sender,
            SP.Seller,
            SP.Company,
            SP.numberofShares,
            paymentSTT
        );
    }
}
