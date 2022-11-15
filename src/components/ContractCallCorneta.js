import { useConnect } from "@stacks/connect-react";
import { StacksTestnet } from "@stacks/network";
import {
  AnchorMode,
  falseCV,
  intCV,
  PostConditionMode,
  tupleCV,
} from "@stacks/transactions";
import { userSession } from "./ConnectWallet";
import Button from 'react-bootstrap/Button';
import { useEffect, useState } from "react";
import { Badge, ButtonGroup, Card, Col, Dropdown, DropdownButton, Row } from "react-bootstrap";
import "../ContractCallCorneta.css";
import axios from "axios";
import { Link, Navigate } from "react-router-dom";
import { toast, ToastContainer } from "react-toastify";
import 'react-toastify/dist/ReactToastify.css';
// ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC.bet-test-nara

const ContractCallCorneta = () => {
  // http://44.201.160.92/corneta/matches
  // const url = 'http://44.201.160.92';
  const url = 'http://localhost:3000';
  const defaultRound = 'Grupos 1';
  const { doContractCall } = useConnect();
  const [match, setMatch] = useState(null);
  const [isEmpty, setIsEmpty] = useState(true);
  const [doBet, setDoBetForUser] = useState(null);
  const [guessHomeTeam, setGuessHomeTeam] = useState('');
  const [guessVisitingTeam, setGuessVisitingTeam] = useState('');
  const [roundSelected, setRoundSelected] = useState(defaultRound);

  const headers = {
    'Content-Type': 'application/json',
    "Access-Control-Allow-Origin": "*"
  }

  useEffect(() => {
    loadMatchBet(defaultRound);
  }, []);

  // TODO: Alterar para url de prod
  function loadMatchBet(round) {
    axios.get(`${url}/bet`, { headers: headers }).then((response) => {
      const group = response.data.filter((match) => match.round === round);
      console.log(group);

      setMatch(group);
    });
  }

  const scoreboardHomeTeam = index => e => {
    console.log('Value: ', index, e.target.value);
    const indexInArray = match.findIndex((match) => match.id === index);
    console.log(indexInArray);
    setGuessHomeTeam(e.target.value);
    const matchCopy = [...match];
    matchCopy[indexInArray].homeTeam.scoreboard = e.target.value;
    console.log('matchCopy: ', matchCopy);
    setMatch(matchCopy);
    hasScoreboard(matchCopy[indexInArray]);
  }

  const scoreboardVisitingTeam = index => e => {
    console.log('visiting: ', e.target.value);
    const indexInArray = match.findIndex((match) => match.id === index);
    setGuessVisitingTeam(e.target.value);
    const matchCopy = [...match];
    matchCopy[indexInArray].visitingTeam.scoreboard = e.target.value;
    setMatch(matchCopy);
    hasScoreboard(matchCopy[indexInArray]);
  }

  function callSaveMatch(item) {
    saveMatchBet(item);
  }

  function hasScoreboard(match) {
    if (match.homeTeam.scoreboard.length >= 0 && match.visitingTeam.scoreboard.length >= 0) {
      document.getElementById(`save-bet-${match.id}`).disabled = false;
      document.getElementById(`save-bet-${match.id}`).addEventListener("click", function (event) {
        event.preventDefault();
        console.log(event);
        if(!event.detail || event.detail === 1){
          callSaveMatch(match);
          document.getElementById(`save-bet-${match.id}`).disabled = true;
          event.stopPropagation();
        }
      });
    }

    if (match.homeTeam.scoreboard.length <= 0 || match.visitingTeam.scoreboard.length <= 0) {
      document.getElementById(`save-bet-${match.id}`).disabled = true;
    }
  }

  function selectRound(round) {
    loadMatchBet(round);
    setRoundSelected(round);
  }

  const saveDoBetForUser = (item, i) => {
    console.log(item);
    const bet = {
      guessHomeTeam: item.homeTeam.scoreboard,
      guessVisitingTeam: item.visitingTeam.scoreboard,
      betMade: false,
      discountFromWallet: false
    };

    console.log('bet: ', bet);

    // localhost:8888/corneta/bet/{idBet}/user/{idUser}
    // O id do match eh id da bet
    axios.post(`${url}/doBetForUser`, bet).then((response) => {
      console.log('aposta salva: ', response);
      delete item.homeTeam.scoreboard;
      delete item.visitingTeam.scoreboard;

      Array.from(document.querySelectorAll(`#score-board-${item.id}`)).forEach(
        input => (input.value = "")
      );

      document.getElementById(`save-bet-${item.id}`).disabled = true;
    });
  }

  const notifyError = () => toast.error(
    'Erro, transação cancelada', {
    position: "top-right",
    autoClose: 5000,
    hideProgressBar: false,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    progress: undefined,
    theme: "light",
  }
  )

  const sanitizeDate = (date) => {
    const options = {
      dateStyle: ('full' || 'long' || 'medium' || 'short')
    };

    return new Date(date).toLocaleDateString('pt-br', options);
  }

  const notify = () => toast.success(
    'Palpite salvo com sucesso', {
    position: "top-right",
    autoClose: 5000,
    hideProgressBar: false,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    progress: undefined,
    theme: "light",
  });

  const tupCV = tupleCV({
    id: intCV(2), // TODO: tirar ID em prod
    s1: intCV(2),
    s2: intCV(3),
    free: falseCV(),
  });



  function saveMatchBet(item) {
    // console.log(item);
    doContractCall({
      network: new StacksTestnet(),
      anchorMode: AnchorMode.Any,
      contractAddress: "ST1X0C07T1WN52DQXGAASMQ7P5M357HJGV4PFF6JC",
      contractName: "bet-test-nara",
      functionName: "save-bet",
      functionArgs: [tupCV],
      postConditionMode: PostConditionMode.Allow,
      postConditions: [],
      onFinish: (data) => {
        console.log("onFinish:", data);
        saveDoBetForUser(item);
        notify();
        // Primeiro salva do lado da blockchain
        // No response da transacao com a blockchain pegar o txId e salvar no userBet da API Corneta
        // Depois de finalizado salva na api corneta

        // window
        //   .open(
        //     `https://explorer.stacks.co/txid/${data.txId}?chain=testnet`,
        //     "_blank"
        //   )
        //   .focus();
      },
      onCancel: () => {
        notifyError();
        console.log("onCancel:", "Transaction was canceled");
      },
    });
  }

  if (!userSession.isUserSignedIn()) {
    return null;
  }


  return (
    <>
      <ButtonGroup className="menu-round" aria-label="Basic example">
        <Button variant="light" onClick={() => loadMatchBet(defaultRound)}>1ª Rodada</Button>
        <Button variant="light" onClick={() => loadMatchBet('Grupos 2')}>2ª Rodada</Button>
        <Button variant="light" onClick={() => loadMatchBet('Grupos 3')}>3ª Rodada</Button>
      </ButtonGroup>

      <ToastContainer />

      {
        match && (
          Array.from({ length: Math.ceil(match.length / 4) }, (_, i) => {
            return (
              <Row className="box-row" key={i}>
                {
                  match.slice(i * 4, (i + 1) * 4).map((item, i) => {
                    return (
                      <Col className="col-cards" key={i}>
                        <Card className="card-width">
                          <Card.Body>
                            <Card.Title>
                              {item.round}
                            </Card.Title>
                            <hr></hr>
                            <Card.Subtitle className="mb-2 text-muted">
                              <div className="details">
                                <div>{item.round}</div>

                                <Link to={'messages'} state={{ idBet: 1, idUser: 1 }}>
                                  <Button variant="link">Visualizar detalhes</Button>
                                </Link>
                              </div>
                            </Card.Subtitle>
                            <div>
                              <span className="box-match">
                                <div className="teams">
                                  <label>{item.homeTeam.initials}</label>
                                  <div className={`flag fi fi-${item.homeTeam.flag}`}></div>
                                  <input type="number" id={`score-board-${item.id}`} min="0" max="10" value={item.name} onChange={scoreboardHomeTeam(item.id)} />
                                </div>
                                <i className="fa-sharp fa-solid fa-x"></i>
                                <div className="teams">
                                  <input type="number" id={`score-board-${item.id}`} min="0" max="10" value={item.name} onChange={scoreboardVisitingTeam(item.id)} />
                                  <div className={`flag fi fi-${item.visitingTeam.flag}`}></div>
                                  <label className="visitingTeam">{item.visitingTeam.initials}</label>
                                </div>
                              </span>

                              <Row>
                                <Col className="box-info-match">
                                  <Badge pill bg="light" text="dark">
                                    <i className="icon fa-regular fa-calendar-days"></i>
                                    {sanitizeDate(item.gameDate)}
                                  </Badge>
                                </Col>
                              </Row>
                            </div>
                            <Button key={i} id={`save-bet-${item.id}`} className="save-bet"
                              disabled={true}
                              onClick={() => saveMatchBet(item)}>Salvar palpite</Button>
                          </Card.Body>
                        </Card>
                      </Col>
                    )
                  })
                }
              </Row>
            )
          })
        )
      }
    </>
  );
};

export default ContractCallCorneta;
