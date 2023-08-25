import express from 'express';
import db from '../models/index.js'
import crypto from "crypto"
import jwt from 'jsonwebtoken'
import { secret as configSecret } from '../config/config.js'
const user = db.models.user;

const router = express.Router();

router.post('/login', async (req, res) => {
    const { email, password } = req.body

    // password 암호화 
    let hashAlgorithm = crypto.createHash('sha512') // sha512 암호 알고리즘
    let hashing = hashAlgorithm.update(password);
    let hashedPassword = hashing.digest('base64');

    try {
        const result = await user.findOne({
            where: { 'u_name': email, 'u_password': hashedPassword }
        })
        const secret = configSecret
        jwt.sign({
            u_name: result.u_name,
            u_nickname: result.u_nickname,
        },
            secret, {
            expiresIn: '1h'
        },
            (err, token) => {
                if (err) {
                    console.log(err);
                    res.status(401).json({ "결과": "로그인 실패", "에러": err })

                } else {
                    res.status(200).json({ "결과": "로그인 성공", 'accessToken': token });

                }
            }
        )
    } catch (error) {

    }

})

router.post('/join', async (req, res) => {
    const { email, nickName, password, major } = req.body
    console.log(email, nickName, password);
    // password 암호화 
    let hashAlgorithm = crypto.createHash('sha512') // sha512 암호 알고리즘
    let hashing = hashAlgorithm.update(password);
    let hashedPassword = hashing.digest('base64');

    console.log(hashedPassword);
    console.log(email, nickName, password, major);
    try {
        const result = await user.create({
            u_name: email, u_nickname: nickName, u_password: hashedPassword, u_major: major
        })
        res.status(200).json({ "결과": "회원가입 성공", });
        console.log(result);
    } catch (error) {
        res.status(403).json({ "결과": "회원가입에 실패했습니다. 입력사항을 확인해주세요.", });
    }
})

export default router;