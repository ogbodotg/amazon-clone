const jwt = require("jsonwebtoken");
const User = require("../models/users");



const adminMiddleware = async (req, res, next) => {
  try {
    const token = req.header("auth-token");
    if (!token)
      return res
        .status(401)
          .json({ msg: "Access denied because no token or invalid token" });
    const verified = jwt.verify(token, "key");
    if (!verified)
      return res.status(401).json({ msg: "Token verification failed" });
      const user = await User.findById(verified.id);
      if (user.type != 'admin') {
          return res.status(401).json({msg: 'Unauthorized user'});
      }
    
      req.user = verified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = adminMiddleware;
