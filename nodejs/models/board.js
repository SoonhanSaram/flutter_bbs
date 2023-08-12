import Sequelize from 'sequelize';
export default (sequelize) => {
  return sequelize.define('board', {
    b_num: {
      type: Sequelize.DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    b_title: {
      type: Sequelize.DataTypes.STRING(255),
      allowNull: false
    },
    b_text: {
      type: Sequelize.DataTypes.TEXT,
      allowNull: false
    },
    b_image: {
      type: Sequelize.DataTypes.BLOB,
      allowNull: true
    },
    b_sdate: {
      type: Sequelize.DataTypes.DATE,
      allowNull: true,
      defaultValue: Sequelize.NOW
    },
    b_udate: {
      type: Sequelize.DataTypes.DATE,
      allowNull: true,
    },
    b_ddate: {
      type: Sequelize.DataTypes.DATE,
      allowNull: true
    },
    b_views: {
      type: Sequelize.DataTypes.INTEGER,
      allowNull: true
    },
    b_nickname: {
      type: Sequelize.DataTypes.STRING(10),
      allowNull: false
    },
    b_category: {
      type: Sequelize.DataTypes.STRING(20),
      allowNull: false,
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
