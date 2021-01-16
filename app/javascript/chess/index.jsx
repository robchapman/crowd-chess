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
import timeReducer from './reducers/time_reducer';
import activeTeamReducer from './reducers/active_team_reducer';
import boardReducer from './reducers/board_reducer';


const chessContainer = document.getElementById('chess_app');

const identityReducer = (state = null, action) => state;

const initialState = {
  time: null,
  activeTeam: null,
  board: [],
  currentGame: JSON.parse(chessContainer.dataset.game)
};

const reducers = combineReducers({
  time: timeReducer,
  activeTeam: activeTeamReducer,
  board: boardReducer,
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
  chessContainer
);



