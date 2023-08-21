import Sequelize from 'sequelize';
export default (sequelize) => {
    return sequelize.define('reReply', {
        rr_num: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        rr_content: {
            type: Sequelize.DataTypes.STRING(255),
            allowNull: false
        },
        rr_nickName: {
            type: Sequelize.DataTypes.TEXT,
            allowNull: false
        },
        rr_num: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
        },
        rr_depth: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
        },
        rr_sdate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true,
            defaultValue: Sequelize.NOW
        },
        rr_udate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true,
        },
        rr_ddate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true
        },
    }, {
        sequelize,
        tableName: 'reReply',
        timestamps: false,
        indexes: [
            {
                name: "PRIMARY",
                unique: true,
                using: "BTREE",
                fields: [
                    { name: "rr_num" },
                ]
            },
        ]
    });
};
