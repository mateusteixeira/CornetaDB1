import "./App.css";
import ConnectWallet, { userSession } from "./components/ConnectWallet";
import ContractCallVote from "./components/ContractCallVote";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from "react";
import axios from "axios";
import { Button, Col, Container, Form, Navbar, Row } from "react-bootstrap";
import ContractCallCorneta from "./components/ContractCallCorneta";


function App() {
  const url = 'http://44.201.160.92';
  const [newUser, setNewUser] = useState(null);

  useEffect(() => {
    userExists()

  }, []);

  function userExists() {
    if (!userSession.isUserSignedIn()) {
      console.log(' fazer nada');
    } else {
      axios.post(`${url}/corneta/user/signin`, { blockChainCode: userSession.loadUserData().profile.stxAddress.testnet }).then((response) => {
        console.log('response: ', response);
        setNewUser(true);
      }).catch((err) => {
        if (err.response.status === 401) {
          setNewUser(false);
        }
      });
    }
  }

  // {/* ContractCallVote file: `./src/components/ContractCallVote.js` */}
  //         {/* <ContractCallVote /> */}
  return (
    <>
      {/* <div className="App">
        <header className="App-header">
          <img src="https://i.pinimg.com/564x/c4/63/98/c4639855e84f992b7dbed318972b86fd.jpg" className="App-logo" alt="logo" />

          <h2>Bem vindo ao Corneta</h2>
          <ConnectWallet />
          <p>
            Conecte sua carteira para ter acesso à aplicação
          </p>
        </header>
      </div> */}

      <Container fluid>
        <Navbar className="navbar">
          <Container>
            <Navbar.Brand href="#home" className="brand">
            <img
              src="https://img.icons8.com/external-stickers-smashing-stocks/70/000000/external-26-independence-day-4th-of-july-stickers-smashing-stocks.png"
              width="50"
              height="50"
              className="d-inline-block align-top"
              alt="React Bootstrap logo"
            />{' '}
            Corneta
            </Navbar.Brand>
            <Navbar.Toggle />
            <Navbar.Collapse className="justify-content-end">
              <Navbar.Text>
                <ConnectWallet />
              </Navbar.Text>
            </Navbar.Collapse>
          </Container>
        </Navbar>

        <Container>
          <ContractCallCorneta/>
        </Container>
      </Container>

    </>
  );
}

export default App;
