import React, { Component } from 'react';
import { Signin } from './Signin';
import { Header } from './Header';
import { ThemeProvider, theme, CSSReset, ToastProvider } from '@blockstack/ui';
import { TodoList } from './TodoList';
import { userSession } from '../auth';

import { UserForm } from './User/UserForm';
import axios from 'axios';
import { Home } from './home/Home';

export default class App extends Component {
  state = {
    userData: null,
  };

  handleSignOut(e) {
    e.preventDefault();
    this.setState({ userData: null });
    userSession.signUserOut(window.location.origin);
  }

  userHasExists() {
    const user = {
      blockChainCode: JSON.parse(localStorage.getItem('blockstack-session')).userData.appPrivateKey
    };

    // axios.post(`http://localhost:3000/user/sigin`, user).then((result) => {
    //   console.log(result);
    // });
    return true;
  }

  render() {
    return (
      <ThemeProvider theme={theme}>
        <ToastProvider>
          <div className="site-wrapper">
            <div className="site-wrapper-inner">
              <Header />
              {!userSession.isUserSignedIn() ? <Signin /> : this.userHasExists() === false ? <UserForm /> : <Home/>}
            </div>
          </div>
        </ToastProvider>
        <CSSReset />
      </ThemeProvider>
    );
  }

  componentDidMount() {
    if (userSession.isSignInPending()) {
      userSession.handlePendingSignIn().then(userData => {
        window.history.replaceState({}, document.title, '/');
        this.setState({ userData: userData });
      });
    } else if (userSession.isUserSignedIn()) {
      this.setState({ userData: userSession.loadUserData() });
      this.userHasExists();
    }
  }
}
