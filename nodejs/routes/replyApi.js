import express from 'express'
import db from '../models/index.js'
import jwt from 'jsonwebtoken'
import { secret as configSecret } from '../config/config.js'

const router = express.Router();
const reply = db.models.reply;

router.post('/insert', async (req, res) => {
    const token = req.header('Access-Token')
    let { content, postNum } = req.body
    postNum = Number(postNum);
    let nickname = "";
    jwt.verify(token, configSecret, (error, decoded) => {
        if (error) {
            console.log(`에러 ${error}`)
        }
        // console.log(decoded);
        nickname = decoded.u_nickname
    })

    if (token) {
        try {
            const result = await reply.create({ r_content: content, r_nickName: nickname, rb_num: postNum },)
            console.log(result);
            res.status(200).json({ '결과': '성공' })
        } catch (error) {

        }
    }


})


router.delete('/delete', async (req, res) => {
    const token = req.header('Access-Token')
    let replyNum = req.header('replynumber')
    replyNum = Number(replyNum);
    // console.log(req.headers);
    let nickName = "";
    jwt.verify(token, configSecret, (error, decoded) => {
        if (error) {
            console.log(`에러 ${error}`)
        }
        nickName = decoded.u_nickname
    })

    if (token) {
        try {
            const getReply = await reply.findOne({ where: { r_num: replyNum } })
            // console.log(getReply.r_nickName);

            if (getReply.r_nickName == nickName) {
                console.log("아이다가 일치 합니다.")
                await reply.destroy({ where: { r_num: replyNum } })
                res.status(200).json({ "결과": "댓글이 삭제 되었습니다." })
            } else {
                console.log("아이다가 일치하지 않습니다.")
                res.status(401).json({ "결과": "댓글을 삭제할 권한이 없습니다." })
            }
        } catch (error) {

        }
    }
})

export default router;