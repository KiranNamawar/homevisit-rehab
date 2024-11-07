import { Hono } from "hono";
import appointment from "./appointment";

const user = new Hono();
user.route('/appointment', appointment);

user.get('/', (c) => {
    return c.text('Hello from user');
})


export default user;