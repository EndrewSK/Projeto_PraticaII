module.exports = (app) => {
    app.use((req, res, next) => {res.header("Access-Control-Allow-Origin", "*");
        next();
    });

    const obj = require("../controllers/controller");
    const objController = new obj();

    app.get("/", (req, res) => {res.render("home")});
    app.get("/login", (req, res) => {res.render("login")});
    app.get("/register", (req, res) => {res.render("register")});
    app.get("/about", (req, res) => {res.render("about")});
    app.get("/contact", (req, res) => {res.render("contact")});

    app.post('/add', objController.add());
};