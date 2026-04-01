---
name: security-review
description: Security scanning. Auto-activates on auth, API keys, user input. Triggers on auth, password, JWT, CORS, XSS, SQL injection, secrets.
---

## Security Checks
**Red flags:** eval() with user input, SQL concatenation, hardcoded secrets, dangerouslySetInnerHTML, chmod 777, CORS *, disabled CSRF, plain text passwords.
**OWASP Top 10:** Injection, broken auth, sensitive data, XSS, broken access control.
**Fixes:** Secrets to env vars. SQL to parameterized. XSS to output encoding + CSP.
