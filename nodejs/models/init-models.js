import _board from "./board.js";
import _boardList from "./boardlist.js";
import _user from "./user.js"
function initModels(sequelize) {
  var board = _board(sequelize);
  var boardList = _boardList(sequelize);
  var user = _user(sequelize);

  return {
    board,
    boardList,
    user,
  };
}
export default initModels;
