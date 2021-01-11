import React from 'react';
import GameBar from '../containers/clock';
import GameBar from '../containers/team_banner';


const GameBar = () => {
  return (
    <div className=".game-bar">
        <TeamBanner />
        <Clock />
        <TeamBanner />
    </div>
  );
};

export default GameBar;
