import express from 'express';
import db from '../models/index.js'
import jwt from 'jsonwebtoken'
import sequelize from 'sequelize'
import { secret as configSecret } from '../config/config.js'
const bbsList = db.models.boardList
const board = db.models.board
const reply = db.models.reply;
const router = express.Router();

router.get("/", async (req, res) => {
    console.log("리스트 get 연결")


    const boardlist = await bbsList.findAll();

    res.status(200).json(boardlist);
})

router.get("/posts/:num", async (req, res) => {
    // console.log(req.params.num)
    try {
        if (req.params.num != null) {
            const result = await board.findOne({ where: { b_num: req.params.num } })
            // console.log(result);
            res.status(200).json(result)
        }
    } catch (error) {

    }
})

router.get("/board/:name", async (req, res) => {
    // console.log(req.params.name);
    try {
        // posting 결과와 댓글 수 같이 가져오기
        if (req.params.name != null) {
            const result = await board.findAll({
                where: { b_category: req.params.name },
                include: [
                    {
                        model: reply,
                        as: 'replies',
                        attributes: [],
                    }
                ],
                attributes: {
                    include: [
                        [
                            sequelize.literal(`(
                    SELECT COUNT(*)
                    FROM reply
                    WHERE reply.rb_num = board.b_num
                )`),
                            'repliesCount'
                        ],
                    ]
                },
                group: ['board.b_num'],
                raw: true,
            });
            console.log(result);
            res.status(200).json(result);
        }


    } catch (error) {
        console.log(error);
    }

})

router.post("/insertPosting", async (req, res) => {
    // console.log(req.body);
    const token = req.header('Access-Token');
    let nickname = "";
    jwt.verify(token, configSecret, (error, decoded) => {
        if (error) {
            console.log(`에러 ${error}`)
        }
        // console.log(decoded);
        nickname = decoded.u_nickname
    })

    if (req.body.board != null && req.body.title != null && req.body.content != null) {
        const result = await board.create({ b_title: req.body.title, b_text: req.body.content, b_category: req.body.board, b_nickname: nickname },)
        console.log(result);
    }

    res.status(200).json({ "결과": "성공" });
})

router.get('/getReply', async (req, res) => {
    let postNumber = req.headers.postnum;
    postNumber = Number(postNumber)

    try {
        console.log(`댓글 호출 실행, ${postNumber}`)
        const result = await reply.findAll({ where: { rb_num: postNumber } })
        console.log(result);
        res.status(200).json(result);
    } catch (error) {

    }
})

export default router