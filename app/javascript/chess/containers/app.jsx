import React from 'react';
import GameBar from '../components/game_bar';
import Board from '../components/board';

const App = () => {
  return (
    <div className="messaging-outer-wrapper">
      <div className="messaging-wrapper">
        <GameBar />
        <Board />
      </div>
    </div>
  );
};

export default App;
