import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import Clock from '../containers/clock';
import TeamBanner from '../containers/team_banner';

class GameBar extends Component {
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
            <p>{`White: ${0} players`}</p>
            <p>{`Playing as: ${this.props.playerTeam}`}</p>
            <p>{`Black: ${0} players`}</p>
          </div>
        </div>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    playerTeam: state.playerTeam
  };
}

// function mapDispatchToProps(dispatch) {
//   return bindActionCreators({  }, dispatch);
// }

export default connect(mapStateToProps, null)(GameBar);
