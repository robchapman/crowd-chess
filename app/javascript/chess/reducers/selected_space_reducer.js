import { SELECT_PIECE } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case SELECT_PIECE: {
      if (state) {
        return null;
      } else {
        return action.payload.selected;
      }
    }
    default: {
      return state;
    }
  }
}
