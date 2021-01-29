import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { fetchMessages } from '../actions';
import Message from '../components/message';
import MessageForm from '../containers/message_form';

import consumer from "../../channels/consumer"
import { strToRGB } from '../../components/strToRGB';

class MessageList extends Component {
  componentWillMount() {
    this.fetchMessages();
    let boundFetchMessages = this.fetchMessages.bind(this);
    consumer.subscriptions.create({ channel: "ChatChannel", state: "messages" }, {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("UPDATING MESSAGES IN CHAT");
        boundFetchMessages();
      }
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
    // const userNickname = document.getElementById('chat_app').dataset.nickname;
    return (
      <div className="channel-container">
        <div className="channel-heading">
          <div className="channel-nickname">
            <span style={{ color: strToRGB(this.props.userNickname) }} >Chatting as: <b>{this.props.userNickname}</b></span>
          </div>
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
    currentGame: state.currentGame,
    userNickname: state.userNickname
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchMessages }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(MessageList);
