import { FETCH_BOARD, SELECT_PIECE, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload;
    }
    case SELECT_PIECE: {
      let new_state = [];
      Object.assign(new_state, state);
      selectSpace(new_state, action.payload['selected']);
      highlightSpaces(new_state, action.payload['moveOptions'], action.payload['selected'], action.payload['prevSelected']);
      return new_state;
    }
    case MAKE_MOVE:{
      let new_state = [];
      Object.assign(new_state, state);

      subseqSpaceHighlighting(new_state, action.payload['moveOptions']);
      return new_state;
    }
    default:
      return state;
  }
}

const selectSpace = (state, selectedSpaceId, prevSelectedId) => {
  state.forEach((space, index) => {
    // If other space is already selected set to off
    if (space['id'] != selectedSpaceId && state[index]['selected']) {
      state[index]['selected'] = null;
    }
    // Switch payload space on
    if (space['id'] == selectedSpaceId) {
      if (state[index]['selected']) {
        state[index]['selected'] = null;
      } else {
        state[index]['selected'] = 'piece-selected';
      }
    }
  });
  return state;
}

const highlightSpaces = (state, moves, selectedSpaceId, prevSelectedId) => {
  state.forEach((space, index) => {
    // If other space is already highlighted set to off
    if (state[index]['highlight']) {
      state[index]['highlight'] = null;
    }

    // Check if clicked space is already selected
    if (prevSelectedId != selectedSpaceId) {
      // Switch move Option spaces on
      if (moves.includes(space['id'])) {
        state[index]['highlight'] = 'board-move-option';
      }
    }
  });
  return state;
}
