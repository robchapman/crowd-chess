import { FETCH_CHANNELS } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_CHANNELS: {
      return action.payload;
    }
    default: {
      return state;
    }
  }
}
