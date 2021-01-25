import React, { Component } from 'react';

import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { selectChannel, fetchMessages } from '../actions/index';

import Clock from '../containers/clock';
import TeamBanner from '../containers/team_banner';

class GameBar extends Component {
  render() {
    return (
      <div className="game-bar">
          <TeamBanner team="white" />
          <Clock />
          <TeamBanner team="black"/>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    FEN: state.FEN,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ selectChannel, fetchMessages }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(GameBar);
