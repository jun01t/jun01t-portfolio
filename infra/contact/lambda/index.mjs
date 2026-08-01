import { SESClient, SendEmailCommand } from '@aws-sdk/client-ses'

const ses = new SESClient({})

const TO_EMAIL = process.env.TO_EMAIL || 'tmdjnch0901@gmail.com'
const FROM_EMAIL = process.env.FROM_EMAIL || TO_EMAIL
const ALLOWED_ORIGINS = (process.env.ALLOWED_ORIGINS || 'https://jun01t-portfolio.jun01t.com')
  .split(',')
  .map((s) => s.trim())
  .filter(Boolean)

const SUBJECT_LABELS = {
  'web-development': 'Web開発のご相談',
  consulting: '技術コンサルティング',
  collaboration: 'コラボレーション',
  other: 'その他',
}

const MAX = {
  name: 100,
  email: 254,
  subject: 64,
  message: 5000,
}

/** @type {Map<string, { count: number, resetAt: number }>} */
const rateBuckets = new Map()
const RATE_LIMIT = 5
const RATE_WINDOW_MS = 60 * 60 * 1000

function corsHeaders(origin) {
  const allowed = origin && ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0]
  return {
    'Access-Control-Allow-Origin': allowed,
    'Access-Control-Allow-Headers': 'content-type',
    'Access-Control-Allow-Methods': 'POST,OPTIONS',
    'Content-Type': 'application/json; charset=utf-8',
    Vary: 'Origin',
  }
}

function json(statusCode, body, origin) {
  return {
    statusCode,
    headers: corsHeaders(origin),
    body: JSON.stringify(body),
  }
}

function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}

function clientIp(event) {
  const fromHeader = event.headers?.['x-forwarded-for'] || event.headers?.['X-Forwarded-For']
  if (fromHeader) return String(fromHeader).split(',')[0].trim()
  return event.requestContext?.http?.sourceIp || 'unknown'
}

function hitRateLimit(ip) {
  const now = Date.now()
  const bucket = rateBuckets.get(ip)
  if (!bucket || now > bucket.resetAt) {
    rateBuckets.set(ip, { count: 1, resetAt: now + RATE_WINDOW_MS })
    return false
  }
  bucket.count += 1
  return bucket.count > RATE_LIMIT
}

function parseBody(event) {
  if (!event.body) return null
  const raw = event.isBase64Encoded
    ? Buffer.from(event.body, 'base64').toString('utf8')
    : event.body
  try {
    return JSON.parse(raw)
  } catch {
    return null
  }
}

export async function handler(event) {
  const origin = event.headers?.origin || event.headers?.Origin || ''

  if (event.requestContext?.http?.method === 'OPTIONS') {
    return {
      statusCode: 204,
      headers: corsHeaders(origin),
      body: '',
    }
  }

  if (event.requestContext?.http?.method !== 'POST') {
    return json(405, { error: 'Method not allowed' }, origin)
  }

  if (origin && !ALLOWED_ORIGINS.includes(origin)) {
    return json(403, { error: 'Origin not allowed' }, origin)
  }

  const ip = clientIp(event)
  if (hitRateLimit(ip)) {
    return json(429, { error: 'Too many requests. Please try again later.' }, origin)
  }

  const data = parseBody(event)
  if (!data || typeof data !== 'object') {
    return json(400, { error: 'Invalid JSON body' }, origin)
  }

  const name = String(data.name ?? '').trim()
  const email = String(data.email ?? '').trim()
  const subject = String(data.subject ?? '').trim()
  const message = String(data.message ?? '').trim()

  if (!name || !email || !subject || !message) {
    return json(400, { error: 'Missing required fields' }, origin)
  }
  if (name.length > MAX.name || email.length > MAX.email || subject.length > MAX.subject || message.length > MAX.message) {
    return json(400, { error: 'Field too long' }, origin)
  }
  if (!isValidEmail(email)) {
    return json(400, { error: 'Invalid email' }, origin)
  }

  const subjectLabel = SUBJECT_LABELS[subject] || subject
  const textBody = [
    'ポートフォリオサイトからのお問い合わせ',
    '',
    `お名前: ${name}`,
    `メールアドレス: ${email}`,
    `件名: ${subjectLabel}`,
    '',
    'メッセージ:',
    message,
  ].join('\n')

  try {
    await ses.send(
      new SendEmailCommand({
        Source: FROM_EMAIL,
        Destination: { ToAddresses: [TO_EMAIL] },
        ReplyToAddresses: [email],
        Message: {
          Subject: {
            Data: `[Portfolio] ${subjectLabel} - ${name}`,
            Charset: 'UTF-8',
          },
          Body: {
            Text: { Data: textBody, Charset: 'UTF-8' },
          },
        },
      }),
    )
  } catch (err) {
    console.error('SES send failed', err)
    return json(500, { error: 'Failed to send email' }, origin)
  }

  return json(200, { ok: true }, origin)
}
