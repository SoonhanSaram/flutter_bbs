import Sequelize from 'sequelize';
export default (sequelize) => {
    return sequelize.define('reply', {
        r_num: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        r_content: {
            type: Sequelize.DataTypes.STRING(255),
            allowNull: false
        },
        r_nickName: {
            type: Sequelize.DataTypes.TEXT,
            allowNull: false
        },
        r_depth: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 1,
        },
        rb_num: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
        },
        r_sdate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true,
            defaultValue: Sequelize.NOW
        },
        r_udate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true,
        },
        r_ddate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true
        },
    }, {
        sequelize,
        tableName: 'reply',
        timestamps: false,
        indexes: [
            {
                name: "PRIMARY",
                unique: true,
                using: "BTREE",
                fields: [
                    { name: "r_num" },
                ]
            },
        ]
    });
};
