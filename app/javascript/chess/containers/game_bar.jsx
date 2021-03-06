import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { setTeamSizes } from '../actions';

import Clock from '../containers/clock';
import TeamBanner from '../containers/team_banner';

import consumer from "../../channels/consumer";

class GameBar extends Component {
  componentWillMount() {
    // Actioncable listening
    let boundSetTeamSizes = this.props.setTeamSizes.bind(this);
    consumer.subscriptions.create({channel: "GameChannel", state: "teamSizes"}, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        boundSetTeamSizes(data);
      }
    });
  }

  pluralize(word, num) {
    if (num != 1) {
      return word+ 's'
    } else {
      return word
    }
  }

  capitalize(word) {

  }

  render() {
    const whitePlayers = this.props.teamSizes.white || 0;
    const blackPlayers = this.props.teamSizes.black || 0;

    return (
      <div className="game-bar">
        <div className="game-bar-upper">
          <TeamBanner team="white" />
          <Clock />
          <TeamBanner team="black"/>
        </div>
        <div className="game-bar-lower">
          <div className="player-stats">
            <div className="left">
              <p>White: <span>{`${whitePlayers} ${this.pluralize('player', whitePlayers)}`}</span></p>
            </div>
            <div className="center">
              <p>Playing as: <span>{`${this.props.playerTeam.capitalize()}`}</span></p>
            </div>
            <div className="right">
              <p>Black: <span>{`${blackPlayers} ${this.pluralize('player', blackPlayers)}`}</span></p>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

String.prototype.capitalize = function() {
  return this[0].toUpperCase() + this.slice(1);
}

function mapStateToProps(state) {
  return {
    playerTeam: state.playerTeam,
    teamSizes: state.teamSizes
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ setTeamSizes }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(GameBar);
