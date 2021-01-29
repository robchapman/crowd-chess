import { SET_GAME } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case SET_GAME: {
      return action.payload
    }
    default:
      return state;
  }
}
