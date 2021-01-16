const BASE_URL = '/api/v1/games';

export const FETCH_BOARD = 'FETCH_BOARD';

export function fetchMessages(game, channel) {
  const url = `${BASE_URL}/${game}/boards/${channel}/messages`;
  const promise = fetch(url, { credentials: "same-origin" }).then(r => r.json());

  return {
    type: FETCH_BOARD,
    payload: promise // Will be resolved by redux-promise
  };
}

