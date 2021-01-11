const GameSpace = gameSpace => {
gameSpace.addEventListener("click", ()=> {
  // Turn off all selected elements on page
  const prevSelected = document.querySelectorAll("piece-selected");
  if (prevSelected) {
    els.forEach(el => {
      prevSelected.classList.remove("piece-selected");
      gameSpace.children[0].classList.toggle("piece-selected");
    });
  }
  gameSpace.children[0].classList.toggle("piece-selected");
  });
};

export default GameSpace;
