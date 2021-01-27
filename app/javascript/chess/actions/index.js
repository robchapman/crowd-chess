import Chess from "chess.js";

// const chess = new Chess();

export const FETCH_BOARD = 'FETCH_BOARD';
export const SELECT_PIECE = 'SELECT_PIECE';
export const MAKE_MOVE = 'MAKE_MOVE';
export const UPDATE_TIMER = 'UPDATE_TIMER';

const BASE_URL = '/api/v1/games';

export function updateTimer(newTimer) {
  return {
    type: UPDATE_TIMER,
    payload: newTimer
  };
}

export function fetchBoard(game) {
  const url = `${BASE_URL}/${game}/board/`;
  const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

  return {
    type: FETCH_BOARD,
    payload: promise // Will be resolved by redux-promise
  };
}

export function selectPiece(clickedSpace, selectedSpace, FEN) {
  const payload = {
    selected: clickedSpace,
    prevSelected: selectedSpace,
    moveOptions: getMoveOptions(clickedSpace, FEN),
  };
  return {
    type: SELECT_PIECE,
    payload: payload
  };
}

export function makeMove(clickedSpace, selectedSpace, FEN, game) {
  // Check if move would produce a game over condition
  // If so send a fetch request to alter GameMaster Model
  const compMoves = null;
  if (!causeGameOver(clickedSpace, selectedSpace, FEN)) {
    const compMoves = getNextMoveOptions(clickedSpace, selectedSpace, FEN);
  } else {
    gameOverFetch();
  }
  let promise = null;
  if (confirmMove(clickedSpace, selectedSpace, FEN)) {
    const url = `${BASE_URL}/${game}/moves`;
    const moveBody = {start: selectedSpace.id, end: clickedSpace.id, compMoves: compMoves};
    promise = moveFetch(url, moveBody);
  }
  return {
    type: MAKE_MOVE,
    payload: promise
  };
}

const getNextMoveOptions = (clickedSpace, selectedSpace, FEN) => {
  const sloppyMove = selectedSpace.notation + clickedSpace.notation;
  const chess = new Chess(FEN);
  chess.move(sloppyMove, {sloppy: true});
  const valid = chess.moves({verbose: true }).map((move)=>{return move.to});
  return valid
}

const getMoveOptions = (clickedSpace, FEN) => {
  const chess = new Chess(FEN);
  const valid = chess.moves({square: clickedSpace.notation, verbose: true }).map((move)=>{return move.to});
  return valid
}

const confirmMove = (clickedSpace, selectedSpace, FEN) => {
  const sloppyMove = selectedSpace.notation + clickedSpace.notation;
  const chess = new Chess(FEN);
  return chess.move(sloppyMove, {sloppy: true});
}

const moveFetch = (url, moveBody ) => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
  const promise = fetch(url, {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(moveBody)
  }).then(r => r.json());
  return promise;
}

const causeGameOver = (clickedSpace, selectedSpace, FEN) => {
  const sloppyMove = selectedSpace.notation + clickedSpace.notation;
  const chess = new Chess(FEN);
  chess.move(sloppyMove, {sloppy: true});
  return chess.game_over();
}

const gameOverFetch = (url) => {

}
