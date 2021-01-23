import { FETCH_BOARD, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload.FEN;
    }
    case MAKE_MOVE: {
      console.log(action.payload.FEN.FEN)
      return action.payload.FEN.FEN
    }
    default:
      return state;
  }
}

