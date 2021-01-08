import React from 'react';
import ChannelList from '../containers/channel_list';
import MessageList from '../containers/message_list';

const App = () => {
  return (
    <div className="messaging-outer-wrapper">
      <div className="messaging-wrapper">
        <ChannelList />
        <MessageList />
      </div>
    </div>
  );
};

export default App;
