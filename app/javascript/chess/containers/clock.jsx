import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
// import { selectChannel, fetchMessages } from '../actions/index';

class Clock extends Component {

  render() {
    return (
      <div className="clock-timer">
        CLOCK
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

// export default connect(mapStateToProps, mapDispatchToProps)(Clock);
export default Clock;
