import { SELECT_PIECE, MAKE_MOVE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case SELECT_PIECE: {
      if (state) {
        return null;
      } else {
        return action.payload.selected;
      }
    }
    case MAKE_MOVE: {
      return null;
    }
    default: {
      return state;
    }
  }
}
