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
import App from './containers/app';

// Reducers
import timerReducer from './reducers/timer_reducer';
import playerTeamReducer from './reducers/player_team_reducer';
import boardReducer from './reducers/board_reducer';
import selectedSpaceReducer from './reducers/selected_space_reducer';
import FENReducer from './reducers/FEN_reducer';
import currentGameReducer from './reducers/current_game_reducer'
import teamSizesReducer from './reducers/team_sizes_reducer'


const chessContainer = document.getElementById('chess_app');

const identityReducer = (state = null, action) => state;

const initialState = {
  timer: 0,
  playerTeam: chessContainer.dataset.team,
  board: [],
  currentGame: JSON.parse(chessContainer.dataset.game),
  selectedSpace: null,
  FEN: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
  teamSizes: JSON.parse(chessContainer.dataset.teamsizes)
};

const reducers = combineReducers({
  timer: timerReducer,
  playerTeam: playerTeamReducer,
  board: boardReducer,
  currentGame: currentGameReducer,
  selectedSpace: selectedSpaceReducer,
  FEN: FENReducer,
  teamSizes: teamSizesReducer
});


// Apply Middlewares
const middlewares = applyMiddleware(logger, ReduxPromise);
const store = createStore(reducers, initialState, middlewares);

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  chessContainer
);



