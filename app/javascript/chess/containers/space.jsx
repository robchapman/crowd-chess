import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
// import { selectChannel, fetchMessages } from '../actions/index';

class Space extends Component {
  // const { colour, highlight, pieceType, pieceTeam, selected, label } = this.props.space;

  renderPiece() {
    const { colour, highlight, pieceType, pieceTeam, selected, label } = this.props.space;
    return (
        <div className={`board-space board-${colour}`}>
          <i className={`fas fa-chess-${pieceType} piece-${pieceTeam}`}></i>
          <span className='board-label-col'>{label[0]}</span>
          <span className='board-label-row'>{label[1]}</span>
        </div>
    );
  }

  renderEmpty() {
    const { colour, highlight, pieceType, pieceTeam, selected, label } = this.props.space;
    return (
        <div className={`board-space board-${colour}`}>
          <span className='board-label-col'>{label[0]}</span>
          <span className='board-label-row'>{label[1]}</span>
        </div>
    );
  }

  render() {
    if (this.props.space.pieceType) {
      return (this.renderPiece());
    }
    else {
      return (this.renderEmpty());
    }
  }
}

// function mapStateToProps(state) {
//   return {
//     channels: state.channels,
//     selectedChannel: state.selectedChannel,
//     currentGame: state.currentGame
//   };
// }

// function mapDispatchToProps(dispatch) {
//   return bindActionCreators({ selectChannel, fetchMessages }, dispatch);
// }

// export default connect(mapStateToProps, mapDispatchToProps)(Space);
export default Space;
