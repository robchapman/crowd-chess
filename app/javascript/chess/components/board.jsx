import React from 'react';
import GameBar from '../containers/space';

const Board = () => {
  return (
    <div className="messaging-outer-wrapper">
      <div className="messaging-wrapper">
        <GameBar />
        <Board />
      </div>
    </div>
  );
};

export default Board;
