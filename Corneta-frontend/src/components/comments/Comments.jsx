import { Box, CSSReset, Flex, Text, theme, ToastProvider } from '@blockstack/ui'
import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { ThemeProvider } from 'styled-components'
import { Header } from '../Header'
import './index.css';

const styleTextarea = {
  border: '1px solid #bdc3c7',
  color: 'gray',
  width: '100%',
  padding: 10,
  borderRadius: 4
}

const btnDisabled = {
  backgroundColor: '#ddd',
  padding: 5,
  color: '#979797',
  borderRadius: 4,
  border: 'none',
  fontFamily: 'Roboto, sans-serif'
}

const btnSaveComment = {
  padding: 5,
  backgroundColor: '#3498db',
  color: '#fff',
  borderRadius: 4,
  border: 'none',
  fontFamily: 'Roboto, sans-serif'
}

export const Comments = () => {
  const location = useLocation();
  const idBet = location.state?.idBet;
  const idUser = location.state?.idUser;

  const [comment, setComment] = useState('');
  const [commentList, setCommentList] = useState([]);

  useEffect(() => {
    // console.log(location);
    getReceivedComments();
  }, []);

  const getReceivedComments = () => {
    axios.get(`http://localhost:3000/receivedMessage?idBetTo=12`).then((response) => {
      console.log(response.data);
      if (response.data.length > 0) {
        setCommentList([...response.data]);
        // response.data.forEach(item => {
        //   console.log('item: ', item);
        //   TODO: Remover, se no response tiver o nome do usuario
        //   axios.get(`http://localhost:3000/user?id=${item.id}`).then((response) => {
        //     console.log('res: ', response.data);
        //     setCommentList([...response.data]);
        //   })
        // });
      }
    });
  }

  const handleCommentChange = event => {
    setComment(event.target.value);
    console.log(event.target.value);
  };

  const createComment = () => {
    const messageData = {
      idBetTo: 12,
      idUserFrom: 1,
      message: comment
    }

    axios.post('http://localhost:3000/message', messageData).then((response) => {
      console.log(response);
      setComment('');
      getReceivedComments();
    });
  }

  return (
    <ThemeProvider theme={theme}>
      <ToastProvider>
        <div className="site-wrapper">
          <div className="site-wrapper-inner">
            <Header />
          </div>

          <Flex>
            <Box maxWidth="660px" width="100%" mx="auto" mt="75px">
              <Flex width="100%" flexWrap="wrap">
                <Link to={-1} className="back-button ">
                  <Text textStyle="display.small" fontSize={1}>Voltar</Text>
                </Link>
                <Box mb={4} width="100%">
                  <Text textStyle="display.large" fontSize={7}>
                    Comentarios
                  </Text>
                </Box>
              </Flex>
              <section>
                <textarea name="comment" id="comment" cols="25" rows="5" style={styleTextarea}
                  placeholder='Escreva um comentario'
                  value={comment}
                  onChange={handleCommentChange}></textarea>
              </section>

              <section>
                <button style={!comment ? btnDisabled : btnSaveComment}
                  disabled={!comment} onClick={createComment}>
                  <Text textStyle="display.large" fontSize={2}>Comentar</Text>
                </button>
              </section>

              <section>
                <hr className='line' />

                <>
                  {commentList && commentList.map((item, i) => {
                    return (
                      <div key={i}>
                        <div>
                          <Text textStyle="display.large" fontSize={2} key={i} className="user-name">{item.userName}</Text>
                        </div>
                        <div key={i} className="message">{item.message}</div>
                      </div>
                    )
                  })}
                </>
              </section>
            </Box>
          </Flex>
        </div>
      </ToastProvider>
      <CSSReset />
    </ThemeProvider>
  )
}
