import React, { Component } from 'react';
import Space from '../containers/space';

import consumer from "../../channels/consumer"
import { fetchBoard } from '../actions';

import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { selectChannel, fetchMessages } from '../actions/index';

class Board extends Component {

  componentWillMount() {
    this.fetchBoard();

    // Actioncable listening
    let boundFetchBoard = this.fetchBoard.bind(this);
    consumer.subscriptions.create({channel: "GameChannel", state: "board"}, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        // console.log("UPDATING BOARD IN CHESS");
        boundFetchBoard();
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
  return bindActionCreators({ fetchBoard }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Board);
