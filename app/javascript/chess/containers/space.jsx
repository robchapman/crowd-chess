import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { selectPiece, makeMove } from '../actions';

import interact from 'interactjs'

class Space extends Component {
  componentDidMount() {
    this.dragSetUp();
  }
  handleClick = () => {
    if (this.props.space.highlight) {
      this.props.makeMove(this.props.space, this.props.selectedSpace, this.props.FEN, this.props.currentGame);
    } else if ((this.props.space.pieceType) && (this.props.space.pieceTeam === this.props.playerTeam)){
      this.props.selectPiece(this.props.space, this.props.selectedSpace, this.props.FEN);
    }
  }

  dragSetUp() {

  }

  renderPiece = (pieceType, pieceTeam, selected) => {
    if (pieceType) {
      return (
        <i
          className={`fas fa-chess-${pieceType} piece-${pieceTeam} ${selected} draggable-piece`}
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
    currentGame: state.currentGame,
    playerTeam: state.playerTeam
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ selectPiece, makeMove }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Space);

