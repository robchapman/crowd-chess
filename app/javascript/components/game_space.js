const GameSpace = gameSpace => {
gameSpace.addEventListener("click", ()=> {
  // Turn off all selected elements on page
  const prevSelected = document.querySelector(".piece-selected");
  // console.log(prevSelected);
  if (prevSelected) {
    prevSelected.classList.remove("piece-selected");
    gameSpace.children[0].classList.toggle("piece-selected");
  } else {
    gameSpace.children[0].classList.add("piece-selected");
  }
  });
};

export default GameSpace;
