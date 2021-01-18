import { FETCH_BOARD, BOARD_INTERACT } from '../actions';

export default function(state = null, action) {
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload;
    }
    case BOARD_INTERACT: {
      let new_state = [];
      Object.assign(new_state, state);
      new_state.forEach((space, index) => {
        if (space['id'] == action.payload['selected']) {
          new_state[index]['selected'] = 'piece-selected';
        }
      });
      return new_state;
    }
    default:
      return state;
  }
}
