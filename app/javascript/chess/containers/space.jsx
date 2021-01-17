import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
// import { selectChannel, fetchMessages } from '../actions/index';

class Space extends Component {
  handleClick = () => {

  }

  renderPiece = (pieceType, pieceTeam) => {
    if (pieceType) {
      return (<i className={`fas fa-chess-${pieceType} piece-${pieceTeam}`}></i>);
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
