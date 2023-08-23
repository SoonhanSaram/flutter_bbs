import express from 'express'
import db from '../models/index.js'
import jwt from 'jsonwebtoken'
import { secret as configSecret } from '../config/config.js'

const router = express.Router();
const reply = db.models.reply;


router.get('/', async (req, res) => {
    const b_num = req.header['b_num'];
    try {
        const result = await reply.findAll({ where: { rb_num: b_num } })
        res.status(200).json(result);
    } catch (error) {

    }
})

router.post('/insert', async (req, res) => {
    const token = req.header('Access-Token')
    const content = req.body.content
    let nickname = "";
    jwt.verify(token, configSecret, (error, decoded) => {
        if (error) {
            console.log(`에러 ${error}`)
        }
        console.log(decoded);
        nickname = decoded.u_nickname
    })

    if (token) {
        try {
            const result = await reply.create({ r_content: content, r_nickName: nickname },)
            console.log(result);
            res.status(200).json({ '결과': '성공' })
        } catch (error) {

        }
    }


})

export default router;