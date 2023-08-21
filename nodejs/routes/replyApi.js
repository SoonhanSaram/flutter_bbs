import express from 'express'
import db from '../models/index.js'


const router = express.Router();

router.post('/insert', async (req, res) => {
    console.log(req.body);
})

export default router;