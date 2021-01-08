import React from 'react';
import { emojify } from 'react-emojione';
import { strToRGB } from '../../components/strToRGB';

const Message = (props) => {
  const { created_at, author, content } = props.message;
  const time = new Date(created_at).toLocaleTimeString();
  return (
    <div className="message-container">
      <i className="author">
        <span style={{ color: strToRGB(author) }}>{author}</span>
        <small>{time}</small>
      </i>
      <p>{emojify(content)}</p>
    </div>
  );
};

export default Message;
