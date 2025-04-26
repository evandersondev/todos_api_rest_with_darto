# 📹 Vídeo 9 — Autenticação com JWT

## 🎯 Objetivo:
Adicionar autenticação com JWT, criando login e protegendo rotas privadas com middleware.

---

## 📦 Estrutura de pastas sugerida

```
src/
├── controllers/
│   └── auth.controller.js
├── middlewares/
│   └── auth.js
├── routes/
│   └── auth.routes.js
├── services/
│   └── auth.service.js
```

---

## 🔐 1. Instalação da lib JWT

```bash
npm install jsonwebtoken
```

---

## 🧠 2. Gerando o token JWT

```js
// services/auth.service.js
import jwt from 'jsonwebtoken';

const SECRET = 'chave_super_secreta';

export function generateToken(user) {
  return jwt.sign({ id: user.id, email: user.email }, SECRET, {
    expiresIn: '1h',
  });
}
```

---

## 📥 3. Rota de login

```js
// controllers/auth.controller.js
import { generateToken } from '../services/auth.service.js';

export function login(req, res) {
  const { email, password } = req.body;

  // Exemplo hardcoded (sem banco ainda)
  if (email === 'admin@email.com' && password === '123456') {
    const token = generateToken({ id: 1, email });
    return res.json({ token });
  }

  return res.status(401).json({ error: 'Credenciais inválidas' });
}
```

---

## 🔐 4. Middleware de autenticação

```js
// middlewares/auth.js
import jwt from 'jsonwebtoken';

const SECRET = 'chave_super_secreta';

export function authenticate(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'Token não fornecido' });

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Token inválido' });
  }
}
```

---

## 🔐 5. Protegendo rotas privadas

```js
// routes/auth.routes.js
import { Router } from 'express';
import { login } from '../controllers/auth.controller.js';
import { authenticate } from '../middlewares/auth.js';

const router = Router();

router.post('/login', login);

// rota protegida
router.get('/me', authenticate, (req, res) => {
  res.json({ user: req.user });
});

export default router;
```

---

## 🧪 Testando no Insomnia/Postman

1. Faça POST em `/login` com email e senha.
2. Copie o token retornado.
3. Faça GET em `/me` com header:

```
Authorization: Bearer <token>
```

---

## 🧠 Conclusão do vídeo

- JWT é uma forma simples e segura de autenticar usuários.
- Criamos middleware reutilizável para proteger rotas privadas.
- Esse sistema pode evoluir com banco de dados e roles de usuário depois.

---

## 💡 Tease para o próximo vídeo:
> "Agora que temos autenticação, no próximo vídeo vamos criar roles de usuário e permissões, controlando quem pode acessar o quê!"