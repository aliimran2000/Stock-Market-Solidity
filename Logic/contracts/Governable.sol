pragma solidity 0.8.7;

/// @title Governable Contract
/// @author github.com/aliimran2000
/// @notice gives any contract a list of governers
contract Governable {
    constructor(string memory _Name) {
        address Owner = msg.sender;
        Governers[Owner] = Governer({
            Name: _Name,
            Governer_ID: Governer_ID_Seed
        });
        GovernerAddresses.push(Owner);

        emit GovernerAdded(Owner, Governer_ID_Seed, Owner);
        Governer_ID_Seed += 1;
    }

    event GovernerAdded(
        address indexed newGoverner,
        uint256 Governer_ID,
        address indexed Addedby
    );

    uint256 private Governer_ID_Seed = 1;
    address[] public GovernerAddresses;

    struct Governer {
        string Name;
        uint256 Governer_ID;
    }

    mapping(address => Governer) Governers;

    modifier onlyGoverner() {
        require(
            Governers[msg.sender].Governer_ID != 0,
            "Governable : caller must be a member of the Governers"
        );
        _;
    }

    function getGoverners() public view returns (address[] memory) {
        return GovernerAddresses;
    }

    function addGoverner(address _newGoverner, string memory _Name)
        public
        payable
        onlyGoverner
    {
        address Owner = msg.sender;

        require(
            Governers[_newGoverner].Governer_ID != 0,
            "governer already added"
        );

        Governers[_newGoverner] = Governer({
            Name: _Name,
            Governer_ID: Governer_ID_Seed
        });
        GovernerAddresses.push(_newGoverner);
        emit GovernerAdded(_newGoverner, Governer_ID_Seed, Owner);
        Governer_ID_Seed += 1;
    }

    function isGoverner(address _addr) public view returns (bool) {
        if (Governers[_addr].Governer_ID != 0) {
            return true;
        }
        return false;
    }
}
