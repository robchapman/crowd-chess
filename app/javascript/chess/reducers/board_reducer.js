import { FETCH_BOARD, SELECT_PIECE, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload;
    }
    case SELECT_PIECE: {
      let new_state = [];
      Object.assign(new_state, state);
      handleSelection(new_state, action.payload);
      handleMoveOptions(new_state, action.payload);
      handleMoveCaptures(new_state, action.payload);
      return new_state;
    }
    case MAKE_MOVE:{
      let new_state = [];
      Object.assign(new_state, state);
      handleSelection(new_state, action.payload);
      handleMoveOptions(new_state, action.payload);
      handleMoveCaptures(new_state, action.payload);

      return state;
    }
    default:
      return state;
  }
}

const handleSelection = (state, payload) => {
  state.forEach((space, index) => {
    // If other space is already selected set to off
    if (space['id'] != payload['selected'] && state[index]['selected']) {
      state[index]['selected'] = null;
    }
    // Switch payload space on
    if (space['id'] == payload['selected']) {
      if (state[index]['selected']) {
        state[index]['selected'] = null;
      } else {
        state[index]['selected'] = 'piece-selected';
      }
    }
  });
  return state;
}

const handleMoveOptions = (state, payload) => {
  const moves = payload['moveOption'];
  // state.forEach((space, index) => {
  //   // If other space is already selected set to off
  //   if (state[index]['selected']) {
  //     state[index]['moveOption'] = null;
  //   }
  //   // Switch payload space on
  //   if (moves.includes(space['id']) {
  //     state[index]['moveOption'] = 'board-move-option';
  //   }
  // });
  return state;
}
