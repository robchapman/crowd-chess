import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { selectPiece, makeMove } from '../actions';

class Space extends Component {
  handleClick = () => {
    if (this.props.space.highlight) {
      this.props.makeMove(this.props.space, this.props.selectedSpace, this.props.FEN, this.props.currentGame);
    } else if (this.props.space.pieceType){
      this.props.selectPiece(this.props.space, this.props.selectedSpace, this.props.FEN);
    }
  }

  renderPiece = (pieceType, pieceTeam, selected) => {
    if (pieceType) {
      return (
        <i
          className={`fas fa-chess-${pieceType} piece-${pieceTeam} ${selected}`}
        ></i>);
    } else {
      return null;
    }
  }

  render() {
    const { colour, highlight, pieceType, pieceTeam, selected, label } = this.props.space;
    return (
      <div className={`board-space board-${colour} ${highlight}`} onClick={this.handleClick}>
        {this.renderPiece(pieceType, pieceTeam, selected)}
        <span className='board-label-col'>{label[0]}</span>
        <span className='board-label-row'>{label[1]}</span>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    selectedSpace: state.selectedSpace,
    FEN: state.FEN,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ selectPiece, makeMove }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Space);

