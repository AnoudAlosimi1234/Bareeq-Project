const express = require("express");
const path = require("path");

const app = express();

app.use(express.json());

app.use("/assets", express.static("assets"));

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "login.html"));
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});