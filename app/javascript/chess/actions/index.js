// import { Chess } from 'chess.js';
// const chess = new Chess();

export const FETCH_BOARD = 'FETCH_BOARD';
export const SELECT_PIECE = 'SELECT_PIECE';
export const MAKE_MOVE = 'MAKE_MOVE';

const BASE_URL = '/api/v1/games';

export function fetchBoard(game) {
  const url = `${BASE_URL}/${game}/board/`;
  const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

  return {
    type: FETCH_BOARD,
    payload: promise // Will be resolved by redux-promise
  };
}

export function selectPiece(clickedSpace, board, selectedSpace) {
  const payload = {
    selected: clickedSpace,
    prevSelected: selectedSpace,
    moveOptions: getMoveOptions(clickedSpace, board),
  };
  return {
    type: SELECT_PIECE,
    payload: payload
  };
}

export function makeMove(clickedSpace, board) {
  const move = {
    selected: clickedSpace
  };
  return {
    type: MAKE_MOVE,
    payload: move
  };
}



const getMoveOptions = (clickedSpace, board) => {
  console.log([clickedSpace + 1, clickedSpace + 2]);
  return [clickedSpace + 1, clickedSpace + 2];
}

// const getCaptureOptions = (clickedSpace, board) => {
//   return [clickedSpace + 3, clickedSpace + 4];
// }
