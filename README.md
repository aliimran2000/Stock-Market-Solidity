Share-Market-Smart-Contract-Docs

# Share-Market-Smart-Contract
Github: [aliimran2000](github.com/aliimran2000)

- The words share and stock  have been used interchangeabliy throughout this project


## Working
### Main Working : 
- users (all members of the network) can purchase stocks from the stock market
- users can post stocks for sale which other users can buy and/or buy directly from the company.
- Each seller can set their own Cost for the transaction
- the currency for the system is `StockToken` **(STT)**


### Governence 
- the initial governer is the contract owner 
- can add other governers to the list of governers
- governers control : 
	1. Company Approval
	2. Add Other Governers to the list of governers
	
### Company 
A company can be created by any user
#### process : 
1. - user request a company creation in which they are required to enter 
	- Name
	- num of stocks
	- stock price	
2. a governer then approves the company request , before that the company is not elligable to sell its stocks

### Stock Token 
- Simple ERC20 Token with top up facility 
- initial supply is provided to the contract address


***
## Diagrams
### Inheritence
![5ce834ba215a95841a066d6e4ea1344f.png](./_resources/c6187747589746e691ea7d5e568f2b1c.png)
***
![21432bc68420d11f373b6ed49ab175ef.png](./_resources/1d509ac3dcea4b6890c41ce142d8723f.png)

***

### interaction



![MyContract.png](./_resources/8d70dcfb7acb4260a639320ee16a3e7a.png)

