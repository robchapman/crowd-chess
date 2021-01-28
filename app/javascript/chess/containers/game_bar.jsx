import React, { Component } from 'react';

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

export default GameBar;
