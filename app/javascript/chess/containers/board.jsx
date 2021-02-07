import React, { Component } from 'react';
import Space from '../containers/space';

import consumer from "../../channels/consumer";
import { fetchBoard, setBoard } from '../actions';

import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { selectChannel, fetchMessages } from '../actions/index';

// import interact from 'interactjs'

class Board extends Component {

  componentWillMount() {
    this.fetchBoard();

    // this.draggableSetUp();

    // Actioncable listening
    let boundSetBoard = this.props.setBoard.bind(this);
    consumer.subscriptions.create({channel: "GameChannel", state: "board"}, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        boundSetBoard(data);
      }
    });
  }

  componentDidMount() {
    this.setWidth();
  }

  setWidth = () => {
    const chess_board = document.querySelector(".board");
    chess_board.style.width = `${chess_board.offsetHeight}px`;
  }

  fetchBoard = () => {
    this.props.fetchBoard(this.props.currentGame);
  }


  // draggableSetUp = () => {
  //   const position = { x: 0, y: 0 }
  //   interact('.draggable-piece').draggable({
  //     listeners: {
  //       start(event) {
  //       },
  //       move (event) {
  //         position.x += event.dx
  //         position.y += event.dy

  //         event.target.style.transform =
  //           `translate(${position.x}px, ${position.y}px)`
  //       }
  //     }
  //   })
  // }

  render() {
    return (
      <div className="board">
        {
          this.props.board.map((space) => {
            return <Space key={space.id} space={space} />;
          })
        }
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    board: state.board,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchBoard, setBoard }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Board);
