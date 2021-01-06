import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { fetchMessages } from '../actions';
import Message from '../components/message';
import MessageForm from '../containers/message_form';

import consumer from "../../channels/consumer"

class MessageList extends Component {

  componentWillMount() {
    this.fetchMessages();

    consumer.subscriptions.create("ChatChannel", {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        this.fetchMessages();      }
    });
  }

    // componentDidMount() {
    //   this.refresher = setInterval(this.fetchMessages, 5000);
    // }

  componentDidUpdate() {
    this.list.scrollTop = this.list.scrollHeight;
  }

  // componentWillUnmount() {
  //   clearInterval(this.refresher);
  // }

  fetchMessages = () => {
    this.props.fetchMessages(this.props.currentGame, this.props.selectedChannel);
  }

  render () {
    return (
      <div className="channel-container">
        <div className="channel-title">
          <span>Channel #{this.props.selectedChannel}</span>
        </div>
        <div className="channel-content" ref={(list) => { this.list = list; }}>
          {
            this.props.messages.map((message) => {
              return <Message key={message.id} message={message} />;
            })
          }
        </div>
        <MessageForm />
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    messages: state.messages,
    selectedChannel: state.selectedChannel,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchMessages }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(MessageList);
