# Série de Vídeos: Criando uma API REST do zero com Dart (Darto)

**Tema da API:** Todo List  
**Stack Utilizada nos Exemplos:** Express.js + Drizzle + Zod  
**Objetivo:** Criar uma série progressiva, indo de uma API simples até uma aplicação REST completa e profissional.

---

## 📹 Vídeo 1 — Criando uma API REST simples (sem banco de dados)

**Objetivo:** Criar uma API com rotas GET, POST, DELETE e PUT em memória.

```js
// server.js
import express from 'express';

const app = express();
app.use(express.json());

let todos = [];
let idCounter = 1;

app.get('/todos', (req, res) => {
  res.json(todos);
});

app.post('/todos', (req, res) => {
  const todo = { id: idCounter++, ...req.body };
  todos.push(todo);
  res.status(201).json(todo);
});

app.put('/todos/:id', (req, res) => {
  const id = +req.params.id;
  const index = todos.findIndex(t => t.id === id);
  if (index === -1) return res.status(404).send('Not found');
  todos[index] = { id, ...req.body };
  res.json(todos[index]);
});

app.delete('/todos/:id', (req, res) => {
  const id = +req.params.id;
  todos = todos.filter(t => t.id !== id);
  res.status(204).send();
});

app.listen(3000, () => {
  console.log('Server started on http://localhost:3000');
});
```

---

## 📹 Vídeo 2 — Organizando a estrutura do projeto

**Objetivo:** Separar rotas, controllers e middlewares.

- Criar pasta `routes`, `controllers`
- Mover lógica das rotas para os controllers
- Criar middleware de logging

---

## 📹 Vídeo 3 — Adicionando validação com Zod

**Objetivo:** Usar o Zod para validar inputs no `POST` e `PUT`.

```js
import { z } from 'zod';

const todoSchema = z.object({
  title: z.string().min(1),
  completed: z.boolean().optional(),
});

app.post('/todos', (req, res) => {
  const result = todoSchema.safeParse(req.body);
  if (!result.success) return res.status(400).json(result.error);
  const todo = { id: idCounter++, ...result.data };
  todos.push(todo);
  res.status(201).json(todo);
});
```

---

## 📹 Vídeo 4 — Persistência com banco de dados usando Drizzle

**Objetivo:** Substituir o array em memória por banco de dados (SQLite).

```js
import { drizzle } from 'drizzle-orm/better-sqlite3';
import Database from 'better-sqlite3';
import { sqliteTable, text, integer } from 'drizzle-orm/sqlite-core';

const db = drizzle(new Database('todos.db'));

const todosTable = sqliteTable('todos', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  title: text('title'),
  completed: integer('completed', { mode: 'boolean' }),
});
```

---

## 📹 Vídeo 5 — Separando camadas: services, repositories

**Objetivo:** Criar camada de serviços e repositórios para deixar o código mais limpo e testável.

---

## 📹 Vídeo 6 — Tratamento de erros global e middlewares customizados

**Objetivo:** Criar middleware de erros e aplicar melhor organização de middlewares.

---

## 📹 Vídeo 7 — Testes automatizados (com Jest)

**Objetivo:** Introduzir testes de integração e unitários.

---

## 📹 Vídeo 8 — Deploy da API (Railway, Render, ou Docker)

**Objetivo:** Subir a API em produção.

---

## 📹 Vídeo 9 — Autenticação com JWT

**Objetivo:** Adicionar login e autenticação protegendo rotas privadas.

---

## 📹 Vídeo 10 — Relacionamentos entre tabelas (ex: Users e Todos)

**Objetivo:** Criar relações entre tabelas com Drizzle.

---
