import Sequelize from 'sequelize';
export default (sequelize) => {
    return sequelize.define('user', {
        u_num: {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        u_name: {
            type: Sequelize.DataTypes.STRING(255),
            allowNull: false,
            unique: true,
        },
        u_nickname: {
            type: Sequelize.DataTypes.STRING(12),
            allowNull: false,
            unique: true,
        },
        u_password: {
            type: Sequelize.DataTypes.STRING(255),
            allowNull: false
        },
        u_major: {
            type: Sequelize.DataTypes.STRING(20),
            allowNull: false
        },
        u_sdate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true,
            defaultValue: Sequelize.NOW
        },
        u_ddate: {
            type: Sequelize.DataTypes.DATE,
            allowNull: true
        },
    }, {
        sequelize,
        tableName: 'user',
        timestamps: false,
    });
};
