import _board from "./board.js";
import _boardList from "./boardlist.js";
import _user from "./user.js"
import _reply from "./reply.js"
import _reReply from "./reReply.js"
function initModels(sequelize) {
  const board = _board(sequelize);
  const boardList = _boardList(sequelize);
  const user = _user(sequelize);
  const reply = _reply(sequelize);
  const reReply = _reReply(sequelize);
  return {
    board,
    boardList,
    user,
    reply,
    reReply
  };
}
export default initModels;
