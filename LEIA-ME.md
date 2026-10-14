# Caderneta de Estádio: como colocar no ar

São 4 arquivos:

| Arquivo | Para que serve |
|---|---|
| `index.html` | O site inteiro (login, ingressos, estádios, perfil, escudos) |
| `config.js` | Onde você cola o endereço e a chave do Supabase |
| `supabase.sql` | Cria as tabelas, as regras de segurança e a pasta de fotos |
| `LEIA-ME.md` | Este guia |

## 1. Supabase (banco, login e fotos)

1. Entre em https://supabase.com e crie um projeto (**New project**). Anote a senha do banco num lugar seguro: o site não usa essa senha, mas o Supabase pede.
2. No projeto, abra **SQL Editor → New query**, cole todo o conteúdo de `supabase.sql` e clique em **Run**. Deve aparecer "Success".
3. Crie o seu usuário: **Authentication → Users → Add user → Create new user**. Preencha seu e-mail e a senha que você quer usar e marque **Auto Confirm User**.
4. Bloqueie cadastros de outras pessoas: **Authentication → Sign In / Providers → Email** (ou **Authentication → Settings**), desligue **Allow new users to sign up** e salve.
5. Pegue as chaves em **Project Settings → API** (ou **API Keys**):
   - **Project URL**, algo como `https://abcd1234.supabase.co`
   - chave **anon public** (na aba *Legacy API keys*) ou a **publishable key**
6. Abra `config.js` num editor de texto e cole os dois valores no lugar de `COLE_AQUI…`.

> Nunca coloque a chave **service_role / secret** no `config.js`. A chave anon pode ficar pública porque as regras do `supabase.sql` só deixam cada usuário ver os próprios dados.

## 2. GitHub Pages (hospedagem grátis)

1. Em https://github.com/new crie um repositório, por exemplo `caderneta-estadio`. O GitHub Pages grátis exige repositório **Public**.
2. Na página do repositório, clique em **Add file → Upload files**, arraste `index.html` e `config.js` (o `supabase.sql` e este guia são opcionais) e clique em **Commit changes**.
3. Vá em **Settings → Pages**. Em *Build and deployment*, escolha **Deploy from a branch**, branch **main**, pasta **/ (root)** e clique em **Save**.
4. Em 1 ou 2 minutos o site fica disponível em `https://SEU-USUARIO.github.io/caderneta-estadio/`.

## 3. Ligar o link de "Esqueci minha senha"

No Supabase, em **Authentication → URL Configuration**:
- **Site URL**: `https://SEU-USUARIO.github.io/caderneta-estadio/`
- **Redirect URLs**: adicione o mesmo endereço.

## 4. Usar no celular

Abra o endereço no celular, entre com seu e-mail e senha e:
- **iPhone (Safari):** botão Compartilhar → **Adicionar à Tela de Início**
- **Android (Chrome):** menu ⋮ → **Adicionar à tela inicial**

Fica com cara de app, com ícone próprio.

## Escudos dos clubes

- São buscados sozinhos no TheSportsDB (gratuito) na primeira vez que um clube aparece, e ficam salvos na sua conta.
- Se algum vier errado ou não aparecer: **Perfil → engrenagem → Ajustar escudos** (ou "Escudo errado?" dentro de um ingresso). Lá dá para enviar uma imagem, colar o link de uma imagem, buscar de novo ou voltar para a sigla.

## Trazer jogos da versão antiga

Se você já registrou jogos na versão em arquivo único, abra ela, vá em **Perfil → botão de dados → Exportar backup** e, no site novo, **Perfil → engrenagem → Importar jogos**. As fotos não vêm junto no backup e precisam ser colocadas de novo.
