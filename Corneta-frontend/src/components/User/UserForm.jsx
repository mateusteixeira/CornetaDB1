import React, { useState, useEffect } from 'react'
import { Flex, Box, Text } from '@blockstack/ui';
import './index.css';
import axios from 'axios';
import { Navigate, useNavigate } from 'react-router-dom';

export const UserForm = () => {
  const navigate = useNavigate();

  const [loading, setLoading] = useState(true);
  const [isPublic, setIsPublic] = useState(false);
  const [username, setUsername] = useState('');
  const [notFound, setNotFound] = useState(false);
  const [state, setState] = useState({
    name: "",
    email: "",
    identityAddress: JSON.parse(localStorage.getItem('blockstack-session')).userData.identityAddress
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setState((prevProps) => ({
      ...prevProps,
      [name]: value
    }));
  };

  const clearFields = () => {
    const initialState = {
      name: "",
      email: "",
      identityAddress: JSON.parse(localStorage.getItem('blockstack-session')).userData.identityAddress
    };

    setState({ ...initialState });
  }

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(state);
    axios.post('http://localhost:3000/createUser', state).then((response) => {
      console.log(response);
      if (response.status === 201) {
        clearFields();
        navigate("/home");
      }
    })
  };

  return (
    <Flex>
      <Box maxWidth="660px" width="100%" mx="auto" mt="75px">
        <Flex width="100%" flexWrap="wrap">
          <Box mb={4} width="100%">
            <Text textStyle="display.large" fontSize={7}>
              Cadastrar usuario
            </Text>
          </Box>

          <div className='card'>
            <form>
              <div className="form-control grid">
                <label>Nome ou apelido</label>
                <input
                  type="text"
                  name="name"
                  value={state.name}
                  onChange={handleInputChange}
                />
              </div>
              <div className="form-control grid field-top">
                <label>Email</label>
                <input
                  type="email"
                  name="email"
                  value={state.email}
                  onChange={handleInputChange}
                />
              </div>
              <div className="form-control field-top box-save-button">
                <button type="button" onClick={handleSubmit}>Salvar</button>
              </div>
            </form>
          </div>
        </Flex>
      </Box>
    </Flex>
  )
}
