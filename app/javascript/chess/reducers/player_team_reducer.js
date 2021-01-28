import { FETCH_PLAYER_TEAM } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_PLAYER_TEAM: {
      return action.payload.team.colour
    }
    default:
      return state;
  }
}
