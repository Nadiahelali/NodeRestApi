const express = require('express')
const app = express()
const port = 3000
const mongoose = require('mongoose')
const dotenv = require('dotenv')
const bodyParser = require('body-parser');

dotenv.config()

app.use(bodyParser.json());

const postsRoute = require('./Routes/posts')

app.use('/posts', postsRoute)

mongoose.connect(process.env.DB_CONNECT, function(err) {
    if (err) {
        console.error(err);
    } else {
        console.log('Connected');
    }    
});

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.listen(port, () => {
    console.log(`app listening at http://localhost:${port}`)
})