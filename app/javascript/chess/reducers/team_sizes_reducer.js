import { SET_TEAM_SIZES } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case SET_TEAM_SIZES: {
      return action.payload;
    }
    default:
      return state;
  }
}
