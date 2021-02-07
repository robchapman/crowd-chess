import { FETCH_BOARD, SET_BOARD, SELECT_PIECE, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload.board;
    }
    case SET_BOARD: {
      return action.payload.board;
    }
    case SELECT_PIECE: {
      let new_state = [];
      Object.assign(new_state, state);
      selectSpace(new_state, action.payload.selected.id);
      highlightSpaces(
        new_state,
        action.payload.moveOptions,
        action.payload.selected.id,
        action.payload.prevSelected?.id
      );
      return new_state;
    }
    case MAKE_MOVE:{
      let new_state = [];
      Object.assign(new_state, state);
      return new_state;
    }
    default:
      return state;
  }
}

const selectSpace = (state, selectedSpaceId) => {
  state.forEach((space, index) => {
    // If other space is already selected set to off
    if (space.id != selectedSpaceId && state[index].selected) {
      state[index].selected = null;
    }
    // Switch payload space on
    if (space.id == selectedSpaceId) {
      if (state[index].selected) {
        state[index].selected = null;
      } else {
        state[index].selected = 'piece-selected';
      }
    }
  });
  return state;
}

const highlightSpaces = (state, moves, selectedSpaceId, prevSelectedId) => {
  state.forEach((space, index) => {
    // If other space is already highlighted set to off
    if (state[index].highlight) {
      state[index].highlight = null;
    }
    // Check if clicked space is already selected
    if (prevSelectedId != selectedSpaceId) {
      // Switch move Option spaces on
      if (moves.includes(space.notation)) {
        state[index].highlight = 'board-move-option';
        if (state[index].pieceType) {
          state[index].highlight = 'board-move-capture';
        }
      }
    }
  });
  return state;
}

const clearSelected = (state) => {
  state.forEach((space, index) => {
    // If any space is already highlighted set to off
    if (state[index].highlight) {
      state[index].highlight = null;
    }
    // If other space is already selected set to off
    if (state[index].selected) {
      state[index].selected = null;
    }
  });
}

const movePiece = (state, endSpaceId, startSpace) => {
  state.forEach((space, index) => {
    if (space.id == endSpaceId) {
      space.pieceTeam = startSpace.pieceTeam
      space.pieceType = startSpace.pieceType
    }
    if (space.id == startSpace.id) {
      space.pieceTeam = null
      space.pieceType = null
    }
  });
}
