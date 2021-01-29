import React, { Component } from 'react';
import GameBar from '../containers/game_bar';
import Board from '../containers/board';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import { fetchGame, fetchPlayerTeam } from '../actions/index';

import consumer from "../../channels/consumer"

class App extends Component {
  ComponentDidMount() {
    // Actioncable listening
    let boundFetchGame = this.fetchGame.bind(this);
    let boundFetchPlayerTeam = this.fetchPlayerTeam.bind(this);
    consumer.subscriptions.create("GameChannel", {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        data.forEach((action) => {
          switch (action) {
            case "CURRENT_GAME": {
              boundFetchGame();
            }
            case "PLAYER_TEAM": {
              boundFetchPlayerTeam(this.props.currentGame);
            }
            default: {}
          }
        });
      }
    });
  }

  render() {
    return (
      <div className="chess-container">
        <GameBar />
        <Board />
      </div>
    );
  };
}

function mapStateToProps(state) {
  return {
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchGame, fetchPlayerTeam }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
