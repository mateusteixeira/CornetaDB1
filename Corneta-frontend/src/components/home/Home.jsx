import React, { useState, useEffect } from 'react'
import { ThemeProvider, theme, CSSReset, ToastProvider, Text, Box, Flex } from '@blockstack/ui';
import { Header } from '../Header';
import axios from 'axios';
import { Link } from 'react-router-dom';
import './index.css';

const flag = {
  marginLeft: 5,
  marginRight: 5,
}
const baseStyle = {
  border: '1px solid #bdc3c7',
  borderRadius: 4,
  width: 380,
  height: 190
}

const headerStyle = {
  padding: '10px',
  display: 'flex',
  justifyContent: 'space-between'
}

const btnDetails = {
  color: '#2196f3',
  fontSize: 12,
  textDecoration: 'underline'
}
const lineStyle = {
  borderColor: '#bdc3c7'
}

const bodyCard = {
  marginTop: '15px'
}

const bodyCardStyle = {
  display: 'flex',
  justifyContent: 'space-evenly'
}

const bodyCardContent = {
  display: 'flex',
  alignItems: 'center'
}

const bodyCardStyleInfo = {
  display: 'flex',
  justifyContent: 'center',
  marginTop: 10
}

const badge = {
  backgroundColor: '#16a085',
  color: '#fff',
  borderRadius: 4,
  padding: 4,
  fontSize: 10,
  height: 20,
  display: 'flex',
  alignItems: 'center'
}

const badgeHour = {
  backgroundColor: '#16a085',
  color: '#fff',
  borderRadius: 4,
  padding: 4,
  fontSize: 10,
  marginRight: 5,
  marginLeft: 5,
  height: 20,
  display: 'flex',
  alignItems: 'center'
}

const inputText = {
  border: '1px solid #ccc',
  width: 45,
  height: 35,
  textAlign: 'center'
}

const btnActions = {
  display: 'flex',
  justifyContent: 'flex-end',
  padding: 10,
  marginTop: 10
}

const btnDisabled = {
  padding: 8,
  backgroundColor: '#ddd',
  color: '#979797',
  borderRadius: 4,
}

const btnSave = {
  padding: 8,
  backgroundColor: '#3498db',
  color: '#fff',
  borderRadius: 4,
}

export const Home = () => {
  const url = 'http://localhost:3000';
  const [bet, setBet] = useState(null);
  const [user, setUser] = useState(null);
  const [isEmpty, setIsEmpty] = useState(true);

  useEffect(() => {
    loadUser();
    loadBets();
  }, []);

  const loadUser = () => {
    const identityAddress = '1KBwL7HX9rj8NPUDhM9M4D3HHQ2khb72aM';
    axios.get(`${url}/createUser?identityAddress=${identityAddress}`).then((response) => {
      setUser(response.data);
    })
  }

  const loadBets = () => {
    axios.get(`${url}/getAllBets`).then((response) => {
      console.log('bets: ', response);
      setBet(response.data);
    });
  }

  const saveBatch = (item) => {
    // console.log('user ', user);
    // console.log('item ', item);
    const doBet = {
      guessHomeTeam: item.homeTeam.scoreboard,
      guessVisitingTeam: item.visitingTeam.scoreboard,
      betMade: false,
      discountFromWallet: false
    };

    console.log('data to save ', item, user);
    // axios.post(`${url}/corneta/bet/${item.id}/${user.id}`, doBet).then((response) => {
    //   console.log(response);
    // });
  }

  const scoreboardHomeTeam = index => e => {
    const matchCopy = [...bet];
    console.log(e.target.value);
    matchCopy[index].homeTeam.scoreboard = e.target.value;
    setBet(matchCopy);
    setIsEmpty(!checkIsEmpty(matchCopy[index]));
  }

  const scoreboardVisitingTeam = index => e => {
    const matchCopy = [...bet];
    matchCopy[index].visitingTeam.scoreboard = e.target.value;
    setBet(matchCopy);
    console.log(!checkIsEmpty(matchCopy[index]));
    setIsEmpty(!checkIsEmpty(matchCopy[index]));
  }

  const checkIsEmpty = (bet) => {
    return bet.homeTeam.scoreboard !== '' && bet.visitingTeam.scoreboard !== '';
  }

  return (
    <ThemeProvider theme={theme}>
      <ToastProvider>
        <div className="site-wrapper">
          <div className="site-wrapper-inner">
            {/* <Header /> */}

            <Flex>
              <Box maxWidth="660px" width="100%" mx="170px" mt="20px">
                <Flex width="100%" flexWrap="wrap">
                  <Box mb={2} width="100%">
                    <Text textStyle="display.large" fontSize={7}>
                      Faça sua aposta
                    </Text>
                  </Box>
                  <section className="grid grid-template-columns-1">
                    <>
                      {bet && bet.map((item, i) => {
                        return (<div className="item" key={i}>
                          <div style={baseStyle}>
                            <section>
                              <header style={headerStyle}>
                                <Text textStyle="display.large" fontSize={2}>
                                  {item.round}ª Rodada
                                </Text>

                                <button style={btnDetails}>
                                  <Link to={{ pathname: "/comments", state: { idBet: 1, idUser: 1 } }}>
                                    <Text textStyle="display.small" fontSize={1}>Visualizar detalhes</Text>
                                  </Link>
                                </button>
                              </header>
                              <hr style={lineStyle} />
                            </section>

                            <section style={bodyCard}>
                              <div style={bodyCardStyle}>
                                <div style={bodyCardContent}>
                                  <Text textStyle="display.large" fontSize={2} >{item.homeTeam.name}</Text>
                                  <span style={flag} className={`fi fi-${item.homeTeam.flag}`}></span>
                                  <input style={inputText} type="number" value={item.name} onChange={scoreboardHomeTeam(i)} />
                                </div>

                                <div style={bodyCardContent}>
                                  x
                                </div>

                                <div style={bodyCardContent}>
                                  <input style={inputText} type="number" value={item.name} onChange={scoreboardVisitingTeam(i)} />
                                  <span style={flag} className={`fi fi-${item.visitingTeam.flag}`}></span>
                                  <Text textStyle="display.large" fontSize={2} >
                                    {item.visitingTeam.name}
                                  </Text>
                                </div>
                              </div>

                              <div style={bodyCardStyleInfo}>
                                <div style={badge}>
                                  <i className="fa fa-calendar"></i>
                                  <span className="label-info">{item.gameDate}</span>
                                </div>

                                <div style={badgeHour}>
                                  <i className="fa fa-clock"></i>
                                  <span className="label-info">
                                    {item.hour}
                                  </span>
                                </div>
                                <div style={badge}>
                                  <i className="fa fa-map-marker" aria-hidden="true"></i>
                                  <span className="label-info">
                                    {item.city}
                                  </span>
                                </div>
                              </div>

                              <div style={btnActions}>
                                {isEmpty}
                                <button key={i}
                                  style={item.homeTeam.scoreboard === '' || item.visitingTeam.scoreboard === '' ? btnDisabled : btnSave}
                                  disabled={isEmpty}
                                  onClick={() => saveBatch(item)}>
                                  <Text textStyle="display.large" fontSize={2}>Salvar</Text>
                                </button>
                              </div>
                            </section>
                          </div>
                        </div>)
                      })}
                    </>
                  </section>
                </Flex>
              </Box>
            </Flex>
          </div>
        </div>
      </ToastProvider>
      <CSSReset />
    </ThemeProvider>
  )
}
