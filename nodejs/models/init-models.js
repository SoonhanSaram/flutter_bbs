import _board from "./board.js";
import _boardList from "./boardlist.js";

function initModels(sequelize) {
  var board = _board(sequelize);
  var boardList = _boardList(sequelize);


  return {
    board,
    boardList,
  };
}
export default initModels;
