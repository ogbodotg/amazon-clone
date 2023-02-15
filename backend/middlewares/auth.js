const jwt = require("jsonwebtoken");


const authMiddleware = async (req, res, next) => {
  try {
    const token = req.header("auth-token");
    if (!token)
      return res
        .status(401)
        .json({ msg: "Access denied because no token or invalid token" });
    const verified = jwt.verify(token, "key");
    if (!verified)
      return res.status(401).json({ msg: "Token verification failed" });
    req.user = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = authMiddleware;
