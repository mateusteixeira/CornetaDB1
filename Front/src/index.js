import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { Connect } from "@stacks/connect-react";

import { userSession } from "./components/ConnectWallet";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Messages from "./components/Messages";
import ContractCallCorneta from "./components/ContractCallCorneta";
import User from "./components/User";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  // <Connect
  //   authOptions={{
  //     appDetails: {
  //       name: "Stacks React Template",
  //       // todo:
  //       icon: window.location.origin + "/logo.png",
  //     },
  //     redirectTo: "/",
  //     onFinish: () => {
  //       window.location.reload();
  //     },
  //     userSession,
  //   }}
  // >
  //   <App />
  // </Connect>
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<Connect
        authOptions={{
          appDetails: {
            name: "Stacks React Template",
            // todo:
            icon: window.location.origin + "/logo.png",
          },
          redirectTo: "/user",
          onFinish: () => {
            window.location.reload();
          },
          userSession,
        }}
      >
        <App />

      </Connect>} />
      <Route path="/user" element={<User/>}/>
      <Route path="/messages" element={<Messages/>}/>
      <Route path="match" element={<ContractCallCorneta/>}/>
    </Routes>
  </BrowserRouter>
);
