import Sequelize from 'sequelize';
export default (sequelize) => {
  return sequelize.define('board', {
    b_num: {
      autoIncrement: true,
      type: Sequelize.DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    b_title: {
      type: Sequelize.DataTypes.STRING(255),
      allowNull: true
    },
    b_text: {
      type: Sequelize.DataTypes.TEXT,
      allowNull: true
    },
    b_image: {
      type: Sequelize.DataTypes.BLOB,
      allowNull: true
    },
    b_sdate: {
      type: Sequelize.DataTypes.STRING(20),
      allowNull: true
    },
    b_udate: {
      type: Sequelize.DataTypes.STRING(20),
      allowNull: true
    },
    b_ddate: {
      type: Sequelize.DataTypes.STRING(20),
      allowNull: true
    },
    b_views: {
      type: Sequelize.DataTypes.INTEGER,
      allowNull: true
    },
    b_nickname: {
      type: Sequelize.DataTypes.STRING(10),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'board',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "b_num" },
        ]
      },
    ]
  });
};
