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
        console.log(data);
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
    return (
      <div className="game-bar">
        <div className="game-bar-upper">
          <TeamBanner team="white" />
          <Clock />
          <TeamBanner team="black"/>
        </div>
        <div className="game-bar-lower">
          <div className="player-stats">
            <p>{`White: ${this.props.teamSizes.white} ${this.pluralize('player', this.props.teamSizes.white)}`}</p>
            <p>{`Playing as: ${this.props.playerTeam}`}</p>
            <p>{`Black: ${this.props.teamSizes.black} ${this.pluralize('player', this.props.teamSizes.black)}`}</p>
          </div>
        </div>
      </div>
    );
  }
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
