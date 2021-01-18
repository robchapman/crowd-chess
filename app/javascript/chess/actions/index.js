const BASE_URL = '/api/v1/games';

export const FETCH_BOARD = 'FETCH_BOARD';
export const BOARD_INTERACT = 'BOARD_INTERACT';

export function fetchBoard(game) {
  const url = `${BASE_URL}/${game}/board/`;
  const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

  return {
    type: FETCH_BOARD,
    payload: promise // Will be resolved by redux-promise
  };
}

export function boardInteract(clickedSpace, board) {
  const updatedSpaces = {
    selected: clickedSpace
  };
  console.log('action');
  return {
    type: BOARD_INTERACT,
    payload: updatedSpaces
  };
}

