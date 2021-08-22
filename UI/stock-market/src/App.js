import React, { useState } from "react";
import FunctionCard from "./Components/FunctionCard";
import Container from "react-bootstrap/Container";
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";
import Web3 from "web3";
import { abi } from "./BlockchainData/abi";
import Spinner from "react-bootstrap/Spinner";
import Button from "react-bootstrap/Button";

function App() {
  const [web3, setWeb3] = useState(null);
  const [Contract, setContract] = useState(null);
  const [account, setAccount] = useState(null);

  const ethereum = window.ethereum;
  console.log(ethereum);

  if (account === null) {
    window.ethereum.enable().then(async () => {
      window.ethereum
        .request({
          method: "eth_requestAccounts",
        })
        .then(async (value) => {
          setAccount(value[0]);
        });
    });
  }

  if (ethereum) {
    ethereum.on("accountsChanged", (acc) => {
      setAccount(acc);
    });
  }

  function setUPWeb3() {
    var tempweb3 = new Web3(Web3.givenProvider || "http://localhost:8545");
    setWeb3(tempweb3);
    setContract(
      new tempweb3.eth.Contract(
        abi,
        "0xaa45a30D22aFf869D838Bfa8c6925ACd75b4d84E"
      )
    );
  }

  return (
    <div>
      {ethereum ? (
        <Container>
          {Contract !== null ? console.log(Contract) : setUPWeb3()}
          <Row>
            <h1>Connected to : {account}</h1>
          </Row>
          <Row>
            <Col sm={3}>
              {Contract !== null ? (
                <div>
                  <FunctionCard
                    foo={Contract.methods.getAllCompanies()}
                    title="getAllCompanies2 "
                    param={{ from: account }}
                  />
                </div>
              ) : null}
            </Col>
            <Col sm={3}>
              {Contract !== null ? (
                <div>
                  <FunctionCard
                    foo={Contract.methods.getGoverners()}
                    title="getGoverners"
                    param={{ from: account }}
                  />
                </div>
              ) : null}
            </Col>
            <Col sm={3}>
              {Contract !== null ? (
                <div>
                  <FunctionCard
                    foo={Contract.methods.addGoverner(
                      "0x8587190DFC61d2d25599B18A56648752813F66C3",
                      "Governer2"
                    )}
                    title="add Governer"
                    params={{ from: account }}
                    send={true}
                  />
                </div>
              ) : null}
            </Col>
          </Row>
        </Container>
      ) : (
        <Button variant="primary" disabled>
          <Spinner
            as="span"
            animation="grow"
            size="sm"
            role="status"
            aria-hidden="true"
          />
          Loading...
        </Button>
      )}
    </div>
  );
}

export default App;
