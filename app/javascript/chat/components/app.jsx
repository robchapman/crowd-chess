import React, { Component } from 'react';
import ChannelList from '../containers/channel_list';
import MessageList from '../containers/message_list';

import { connect } from 'react-redux';

// Higher Order Components
import PageVisibility from 'react-page-visibility';

class App extends Component {

  handleVisibilityChange = (isVisible, visibilityState) => {
    console.log(isVisible);
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

export default connect(mapStateToProps, null)(App);


