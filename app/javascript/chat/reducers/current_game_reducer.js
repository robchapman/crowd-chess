import { FETCH_GAME } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_GAME: {
      return action.payload
    }
    default:
      return state;
  }
}
