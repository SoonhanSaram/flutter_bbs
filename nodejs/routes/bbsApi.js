import express from 'express';
import db from '../models/index.js'

const bbsList = db.models.boardList
const router = express.Router();

router.get("/", async (req, res, next) => {
    console.log("리스트 get 연결")


    const boardlist = await bbsList.findAll();

    res.json(boardlist);
})

export default router