import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import App from './components/App';
import { Comments } from './components/comments/Comments';
import { Home } from './components/home/Home';
import { UserForm } from './components/User/UserForm';

ReactDOM.render(
  <BrowserRouter>
    {/* <App /> */}
    <Routes>
      <Route path="/" element={<App/>}/>
      <Route path="/home" element={<Home/>}/>
      <Route path="/user" element={<UserForm/>}/>
      <Route path="/comments" element={<Comments/>}/>
    </Routes>
  </BrowserRouter>,
  document.getElementById('app')
);
