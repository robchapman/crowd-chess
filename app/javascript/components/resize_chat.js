const ResizeChat = chat => {
  chat.style.minHeight = `${chat.offsetHeight}px`;
  chat.style.top = `${window.innerHeight / 2}px`;
};

export default ResizeChat;
