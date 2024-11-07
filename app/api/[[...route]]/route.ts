import { Hono } from 'hono'
import { handle } from 'hono/vercel'
import user from './user/main'

export const runtime = 'edge'

const app = new Hono().basePath('/api')
app.route('/user', user)

app.get('/hello', (c) => {
  return c.json({
    message: 'Hello Next.js!',
  })
})

export const GET = handle(app)
export const POST = handle(app)