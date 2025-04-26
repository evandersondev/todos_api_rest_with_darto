# 📹 Vídeo 10 — Relacionamentos entre tabelas (ex: Users e Todos)

## 🎯 Objetivo:

Mostrar como criar relacionamentos entre tabelas no banco de dados usando Drizzle (ou Dartonic), e como consultar esses dados relacionados de forma simples e performática.

---

## 🧱 1. Criação das tabelas com relacionamento

```js
// schema/users.js
import { pgTable, serial, varchar } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  email: varchar("email", { length: 256 }).notNull(),
});

// schema/todos.js
import { pgTable, serial, varchar, integer } from "drizzle-orm/pg-core";
import { users } from "./users.js";

export const todos = pgTable("todos", {
  id: serial("id").primaryKey(),
  title: varchar("title", { length: 256 }).notNull(),
  userId: integer("user_id").references(() => users.id),
});
```

🔍 2. Inserindo dados relacionados

```js
// criando usuário
await db.insert(users).values({ email: "joao@email.com" });

// criando todo relacionado ao usuário 1
await db.insert(todos).values({ title: "Fazer compras", userId: 1 });
```

🔎 3. Buscando todos com dados do usuário (JOIN)

```js
import { eq } from "drizzle-orm";
import { todos } from "./schema/todos.js";
import { users } from "./schema/users.js";

const results = await db
  .select()
  .from(todos)
  .leftJoin(users, eq(todos.userId, users.id));

console.log(results);
```

🧠 Conclusão do vídeo

    - Relacionamentos são essenciais em apps reais.

    - O Drizzle facilita JOINs com tipagem forte.

    - Evita necessidade de ORM "pesado" como Prisma.

💡 Tease para o próximo vídeo:

- "No próximo vídeo, vamos melhorar ainda mais nossa API protegendo ações com roles e permissões de usuário!"
