import { Hono } from "hono";
import prisma from "../prisma";
import { randomUUID } from "crypto";

const appointment = new Hono();

appointment.get('/', (c) => {
    return c.text('Hello from appointment');
})

appointment.post('/create', async (c) => {
    const body = await c.req.json();
    console.log(body);
    return c.json({})
})

export default appointment;