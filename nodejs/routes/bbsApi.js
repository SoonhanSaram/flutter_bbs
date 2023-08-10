import express from 'express';
import db from '../models/index.js'

const bbsList = db.models.boardList
const router = express.Router();

router.get("/", async (req, res) => {
    console.log("리스트 get 연결")


    const boardlist = await bbsList.findAll();

    res.json(boardlist);
})

router.get("/board/:name", async (req, res) => {
    console.log(req.params.name);
})
export default router