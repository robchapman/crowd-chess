import { FETCH_BOARD, BOARD_INTERACT } from '../actions';

export default function(state = null, action) {
  console.log("reducer");
  switch (action.type) {
    case FETCH_BOARD: {
      return action.payload;
    }
    case BOARD_INTERACT: {
      console.log("reducers")
      let new_state = state;
      new_state.forEach((space, index) => {
        if (space['id'] == action.payload['selected']) {
          new_state[index]['selected'] = 'piece-selected';
          console.log("selected state change");
        }
      });
      return new_state;
    }
    default:
      console.log("default");
      return state;
  }
}
