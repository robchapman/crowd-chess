import React from 'react';
import GameBar from '../components/game_bar';
import Board from '../containers/board';

const App = () => {
  return (
    <div className="chess-container">
      <GameBar />
      <Board />
    </div>
  );
};

export default App;
