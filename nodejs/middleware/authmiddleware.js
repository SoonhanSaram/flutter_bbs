import jwt from "jsonwebtoken"
import { secret as configSecret } from "../config/config.js"
const authMiddleware = async (req, res, next) => {
    const accessToken = req.header('Access-Token')
    if (accessToken == null) {
        res.status(403).json({ "결과": "토큰이 존재하지 않습니다." })
    } else {
        try {
            const tokenInfo = await new Promise((resolve, reject) => {
                jwt.verify(accessToken, configSecret, (err, decoded) => {
                    if (err) {
                        // console.log(err);
                        reject(err)
                    } else {
                        resolve(decoded)
                    }
                });
            });
            req.tokenInfo = tokenInfo;
            next()
        } catch (error) {
            console.log(error);
            res.status(403).json({ "결과": "토큰 인증 실패" })
        }
    }
}

export default authMiddleware