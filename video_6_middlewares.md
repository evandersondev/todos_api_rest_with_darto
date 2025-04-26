# 📹 Vídeo 6 — Tratamento de erros global e middlewares customizados

## 🎯 Objetivo:
- Criar um middleware de erro global
- Separar middlewares por função
- Mostrar exemplos reais de middlewares reutilizáveis
- Aprimorar a organização do projeto

---

## 📦 Estrutura de pastas sugerida

```
src/
├── middlewares/
│   ├── error_handler.js
│   ├── logger.js
│   └── validate.js
```

---

## 💥 1. Middleware de erro global

```js
// middlewares/error_handler.js
export function errorHandler(err, req, res, next) {
  if (err.name === 'ZodError') {
    return res.status(400).json({ error: err.errors });
  }

  if (err.name === 'NotFoundError') {
    return res.status(404).json({ error: err.message });
  }

  console.error('🔥 Erro interno:', err);
  return res.status(500).json({ error: 'Erro interno do servidor' });
}
```

### 📌 Aplicando na API:

```js
import { errorHandler } from './middlewares/error_handler.js';

app.use(errorHandler);
```

---

## 📋 2. Middleware de logger

```js
// middlewares/logger.js
export function logger(req, res, next) {
  console.log(`[${req.method}] ${req.url}`);
  next();
}
```

```js
import { logger } from './middlewares/logger.js';
app.use(logger); // aplica em todas as rotas
```

---

## ✅ 3. Middleware de validação com Zod

```js
// middlewares/validate.js
export function validate(schema) {
  return (req, res, next) => {
    const parsed = schema.safeParse(req.body);
    if (!parsed.success) {
      return next(parsed.error); // vai pro errorHandler
    }
    req.body = parsed.data; // usa os dados já validados
    next();
  };
}
```

### Uso:

```js
import { validate } from './middlewares/validate.js';
import { z } from 'zod';

const todoSchema = z.object({ title: z.string().min(3) });
app.post('/todos', validate(todoSchema), TodosController.create);
```

---

## 🎯 Extras legais pro vídeo:

### ✨ Mostrar diferença entre:
- Erros lançados (throw new Error)
- Erros tratados via `next(err)`
- Erros inesperados capturados globalmente

### 🧪 Exemplo com erro simulado:

```js
app.get('/boom', (req, res) => {
  throw new Error('Algo deu errado!');
});
```

---

## 🧠 Conclusão do vídeo
- Middleware de erro deixa o código mais limpo
- Middleware de validação reduz código repetido
- Separar middlewares ajuda a manter o projeto escalável

---

## 💡 Tease para o próximo vídeo:
> "Agora que temos uma base sólida com middlewares e tratamento de erros, vamos adicionar autenticação JWT e proteger nossas rotas no próximo vídeo!"