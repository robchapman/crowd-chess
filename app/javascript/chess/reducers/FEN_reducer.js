import { FETCH_BOARD } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload.FEN;
    }
    default:
      return state;
  }
}

