import { UPDATE_TIMER } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case UPDATE_TIMER: {
      return action.payload;
    }
    default:
      return state;
  }
}
