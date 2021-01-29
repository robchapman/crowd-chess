/* eslint no-bitwise:off */

import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import consumer from "../../channels/consumer"
import { selectChannel, fetchMessages, fetchChannels } from '../actions/index';

class ChannelList extends Component {
  componentWillMount() {
    let boundFetchChannels = this.props.fetchChannels.bind(this);
    consumer.subscriptions.create({channel: "ChatChannel", state: 'channels'}, {
      received: (data) => {
        // Called when there's incoming data on the websocket for this channel
        // console.log("UPDATING CHANNELS IN CHAT");
        boundFetchChannels(this.props.currentGame);
      }
    });
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.selectedChannel !== this.props.selectedChannel) {
    this.props.fetchMessages(this.props.currentGame, nextProps.selectedChannel);    }
  }

  handleClick = (channel) => {
    this.props.selectChannel(channel);
  }

  renderChannel = (channel) => {
    return (
      <li
        key={channel}
        className={channel === this.props.selectedChannel ? 'active' : null}
        onClick={() => this.handleClick(channel)}
        role="presentation"
      >
        #{channel}
      </li>
    );
  }

  render() {
    return (
      <div className="channels-container">
        <ul>
          {this.props.channels.map(this.renderChannel)}
        </ul>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    channels: state.channels,
    selectedChannel: state.selectedChannel,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ selectChannel, fetchMessages, fetchChannels }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ChannelList);
