import React, { Component } from 'react';
import GameBar from '../containers/game_bar';
import Board from '../containers/board';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import { setGame, fetchPlayerTeam } from '../actions/index';

import consumer from "../../channels/consumer"

class App extends Component {
  componentWillMount() {
    // Actioncable listening
    let boundSetGame = this.props.setGame.bind(this);
    consumer.subscriptions.create({channel: "GameChannel", state: 'current_game'}, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("UPDATING CURRENT GAME IN GAME");
        boundSetGame(data);
      }
    });

    let boundFetchPlayerTeam = this.props.fetchPlayerTeam.bind(this);
    consumer.subscriptions.create({channel: "GameChannel", state: 'player_team'}, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("UPDATING PLAYER TEAM IN GAME");
        boundFetchPlayerTeam(this.props.currentGame)
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
  return bindActionCreators({ setGame, fetchPlayerTeam }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
