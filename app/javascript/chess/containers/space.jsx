import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { boardInteract } from '../actions';

class Space extends Component {
  handleClick = () => {
    boardInteract(this.props.space.id, this.props.board);
  }

  renderPiece = (pieceType, pieceTeam) => {
    if (pieceType) {
      return (
        <i
          className={`fas fa-chess-${pieceType} piece-${pieceTeam}`}
          onClick={this.handleClick}
        ></i>);
    } else {
      return null;
    }
  }

  render() {
    const { colour, highlight, pieceType, pieceTeam, selected, label } = this.props.space;
    return (
      <div className={`board-space board-${colour}`}>
        {this.renderPiece(pieceType, pieceTeam)}
        <span className='board-label-col'>{label[0]}</span>
        <span className='board-label-row'>{label[1]}</span>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    board: state.board
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ boardInteract }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Space);

