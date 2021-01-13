import React from 'react';
import Clock from '../containers/clock';
import TeamBanner from '../containers/team_banner';


const GameBar = () => {
  return (
    <div className="game-bar">
        <TeamBanner />
        <Clock />
        <TeamBanner />
    </div>
  );
};

export default GameBar;
