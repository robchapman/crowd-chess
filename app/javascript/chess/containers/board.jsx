import React, { Component } from 'react';
import GameBar from '../containers/space';

class Board extends Component {

  componentDidMount() {
    const chess_board = document.querySelector(".board");
    chess_board.style.width = `${chess_board.offsetHeight}px`
  }

  render() {
    return (
        <div className="board">

        </div>
    );
  }
}

export default Board;

