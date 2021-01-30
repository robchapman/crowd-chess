import { FETCH_BOARD, SET_BOARD, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload.FEN;
    }
    case SET_BOARD: {
      return action.payload.FEN;
    }
    case MAKE_MOVE: {
      return action.payload.FEN
    }
    default:
      return state;
  }
}

