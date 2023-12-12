const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ message: "No authorization token , access denied" });
    }
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) {
      return res
        .status(401)
        .json({ message: "Token Verification failed, access denied" });
    }

    // id and token will setting this to the request so that it will get while fetching the data in the home
    req.user = isVerified.id;
    req.token = token;
    next();
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

module.exports = auth;
