import axios from 'axios';
import React, { useEffect, useState } from 'react'
import { Button, Card, Col, Container, Form, Navbar, Row } from 'react-bootstrap';
import { Link, useLocation } from 'react-router-dom';
import ConnectWallet from './ConnectWallet';
import "../Message.css"

// URL publicada http://44.201.160.92/
const Messages = () => {
  const { state } = useLocation();
  const url = 'http://localhost:3000';
  const [comment, setComment] = useState('');
  const [commentList, setCommentList] = useState([]);

  useEffect(() => {
    console.log('fui chamando', state);
    getReceivedComments();
  }, []);

  const getReceivedComments = () => {
    axios.get(`http://localhost:3000/receivedMessage?idBetTo=12`).then((response) => {
      console.log(response.data);
      if (response.data.length > 0) {
        setCommentList([...response.data]);
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
    <>
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
        <Row>
          <Col>
            <Link to={-1}>
              <Button variant="link">Voltar</Button>
            </Link>
          </Col>
        </Row>
        <Row>
          <Col>
            <h2>Comentarios</h2>
          </Col>
        </Row>

        <Row>
          <Col>
            <Form>
              <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                <Form.Label>Escrever comentario</Form.Label>
                <Form.Control as="textarea" rows={3} value={comment} onChange={handleCommentChange} />
              </Form.Group>

              <Button className='message-btn' disabled={!comment} onClick={createComment}>Comentar</Button>
            </Form>
          </Col>
        </Row>

        <Row>
          <Col>
            <section>
              <hr className='line' />
              <h5 className="list-comments-title box-comment">Lista de comentarios</h5>
              <>
                {commentList && commentList.map((item, i) => {
                  return (
                    <div key={i} className="box-comment">
                      <div>
                        <h6 key={i} className="user-name">{item.userName}</h6>
                      </div>
                      <Card key={i}>
                        <Card.Body className="card-body">{item.message}</Card.Body>
                      </Card>
                    </div>
                  )
                })}

                {commentList.length <= 0 ? <div>Não ha comentarios no momento</div> : null}
              </>
            </section>
          </Col>
        </Row>

      </Container>
    </>

  )
}

export default Messages;