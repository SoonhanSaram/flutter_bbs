import Sequelize from 'sequelize';
export default (sequelize) => {
  return sequelize.define('boardlist', {
    bl_num: {
      type: Sequelize.DataTypes.STRING(3),
      allowNull: false,
      primaryKey: true,
    },
    bl_name: {
      type: Sequelize.DataTypes.STRING(20),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'boardlist',
    timestamps: false
  });
};
