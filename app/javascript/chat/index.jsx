// app/javascript/chat/index.jsx
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware } from 'redux';

// Middleware
import logger from 'redux-logger'
import ReduxPromise from 'redux-promise';
// import { BrowserRouter, Route, Switch } from 'react-router-dom';

//Internal Modules
import App from './components/app';

// Reducers
import messagesReducer from './reducers/messages_reducer';
import selectedChannelReducer from './reducers/selected_channel_reducer';


const chatContainer = document.getElementById('chat_app');

const identityReducer = (state = null, action) => state;

const initialState = {
  messages: [],
  channels: JSON.parse(chatContainer.dataset.channelnames),
  selectedChannel: 'general',
  currentGame: JSON.parse(chatContainer.dataset.game)
};

const reducers = combineReducers({
  messages: messagesReducer,
  channels: identityReducer,
  selectedChannel: selectedChannelReducer,
  currentGame: identityReducer
});


// Apply Middleswares
const middlewares = applyMiddleware(logger, ReduxPromise);
const store = createStore(reducers, initialState, middlewares);

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  chatContainer
);


// With
// ReactDOM.render(
//   <Provider store={store}>
//     <BrowserRouter>
//       <Switch>
//         <Route path="/channels/:channel" component={App} />
//       </Switch>
//     </BrowserRouter>
//   </Provider>,
//   chatContainer
// );
