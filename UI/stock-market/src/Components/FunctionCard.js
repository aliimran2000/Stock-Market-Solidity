import React from "react";
import Card from "react-bootstrap/Card";
import Button from "react-bootstrap/Button";
import Spinner from "react-bootstrap/Spinner";
import InputGroup from "react-bootstrap/InputGroup";
import FormControl from "react-bootstrap/FormControl";

import { useState } from "react";

export default function FunctionCard({ foo, title, params, send }) {
  const [Res, setRes] = useState("");
  const [Failed, setFailed] = useState(false);

  const FunctionCall = async () => {
    try {
      var res;
      if (params) {
        console.log("params : ", params);
        if (send === true) {
          res = await foo.send(params);
        } else {
          res = await foo.call(params);
        }
      } else {
        if (send === true) {
          res = await foo.send();
        } else {
          res = await foo.call();
        }

        setFailed(false);
      }

      console.log("Response : ", res);
      setRes("Transaction SuccesFull : ", res.toString());
    } catch (error) {
      console.log("ERROR : ", error);
      setRes(error.toString());
      setFailed(true);
    }
  };

  return (
    <Card style={{ minwidth: "18rem", height: "18rem" }} border="primary">
      <Card.Body>
        <Card.Title>{title}</Card.Title>

        <Button
          size="lg"
          variant="primary"
          onClick={() => {
            FunctionCall();
          }}
        >
          {send ? "send" : "call"}
        </Button>
        {Failed === false ? null : "Transaction Failed Retry"}

        <InputGroup className="mb-3">
          <InputGroup.Text id="basic-addon1">@</InputGroup.Text>
          <FormControl
            placeholder="Username"
            aria-label="Username"
            aria-describedby="basic-addon1"
          />
        </InputGroup>

        <Card.Text>
          {Res ? Res : <Spinner animation="border" variant="primary" />}
        </Card.Text>
      </Card.Body>
    </Card>
  );
}
