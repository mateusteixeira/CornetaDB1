import React from "react";
import { AppConfig, showConnect, UserSession } from "@stacks/connect";
import { Button } from "react-bootstrap";

const appConfig = new AppConfig(["store_write", "publish_data"]);

export const userSession = new UserSession({ appConfig });

function authenticate() {
  showConnect({
    appDetails: {
      name: "Stacks React Starter",
      icon: window.location.origin + "/logo512.png",
    },
    redirectTo: "/user",
    onFinish: () => {
      console.log('logdd');
      window.location.reload();

    },
    userSession,
  });
}

function disconnect() {
  userSession.signUserOut("/");
}

const ConnectWallet = () => {
  if (userSession.isUserSignedIn()) {
    return (
      <div>
        <Button variant="light" onClick={disconnect}>
          Desconectar carteira
        </Button>
        {/* <p>mainnet: {userSession.loadUserData().profile.stxAddress.mainnet}</p>
        <p>testnet: {userSession.loadUserData().profile.stxAddress.testnet}</p> */}
      </div>
    );
  }

  return (
    <Button variant="primary" onClick={authenticate}>
      Conectar carteira
    </Button>
  );
};

export default ConnectWallet;
