import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { updateTimer } from '../actions/index';
import consumer from "../../channels/consumer"

class Clock extends Component {

  componentWillMount() {
    let boundUpdateTimer = this.props.updateTimer.bind(this);
    consumer.subscriptions.create("TimerChannel", {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
        boundUpdateTimer(data)
        while (data > 0) {
          setTimeout(boundUpdateTimer(data), 1000);
          data--;
        }
      }
    });
  }

  render() {
    return (
      <div className="clock-timer">
        00:0{this.props.timer}
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    timer: state.timer
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ updateTimer }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Clock);
