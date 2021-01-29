import React, { Component } from 'react';
import ChannelList from '../containers/channel_list';
import MessageList from '../containers/message_list';

import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import { fetchGame } from '../actions/index';

import consumer from "../../channels/consumer"

// Higher Order Components
import PageVisibility from 'react-page-visibility';

class App extends Component {

  ComponentDidMount() {
    this.addUnloadListener();

    // Actioncable listening
    let boundFetchGame = this.fetchGame.bind(this);
    consumer.subscriptions.create("GameChannel", {
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        data.forEach((action) => {
          switch (action) {
            case "CURRENT_GAME": {
              boundFetchGame();
            }
            default: {}
          }
        });
      }
    });

  }

  addUnloadListener = () => {
    window.addEventListener('beforeunload', (event) => {
      this.sendActiveBeacon(false);
    });
  }

  handleVisibilityChange = (isVisible, visibilityState) => {
    // console.log(isVisible);
    // this.sendActiveFetch(isVisible);
    this.sendActiveBeacon(isVisible);
  }

  sendActiveBeacon = (isVisible) => {
    const BASE_URL = '/api/v1/games';
    // const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
    const url = `${BASE_URL}/${this.props.currentGame}/plays/${this.props.userNickname}/beacon`;

    var data = new FormData();
    data.append("play[active]", isVisible);
    var param = document.querySelector("meta[name=csrf-param]").getAttribute("content");
    var token = document.querySelector("meta[name=csrf-token]").getAttribute("content");
    data.append(param, token);

    navigator.sendBeacon(url, data);
  }

  sendActiveFetch = (isVisible) => {
    const BASE_URL = '/api/v1/games';
    const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
    const url = `${BASE_URL}/${this.props.currentGame}/plays/${this.props.userNickname}/`;
    const promise = fetch(url, {
      method: 'PATCH',
      credentials: 'same-origin',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({play: {active: isVisible}})
    })
  }

  render () {
    return (
      <PageVisibility onChange={this.handleVisibilityChange} >
        <div className="messaging-wrapper">
          <ChannelList />
          <MessageList />
        </div>
      </PageVisibility>
    );
  }
}

function mapStateToProps(state) {
  return {
    userNickname: state.userNickname,
    currentGame: state.currentGame
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchGame }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(App);

