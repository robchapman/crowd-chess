import React, { Component } from 'react';
import ChannelList from '../containers/channel_list';
import MessageList from '../containers/message_list';

import { connect } from 'react-redux';

// Higher Order Components
import PageVisibility from 'react-page-visibility';

class App extends Component {

  handleVisibilityChange = (isVisible, visibilityState) => {
    console.log(isVisible);
    console.log(this.props.userNickname)
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
    userNickname: state.userNickname
  };
}

export default connect(mapStateToProps, null)(App);


