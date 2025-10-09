# 🛍️ Sistema de Gerenciamento para Loja de Roupas

Este projeto representa o modelo de dados para um sistema de gerenciamento de uma loja de roupas. O banco de dados foi desenvolvido para organizar eficientemente informações sobre **produtos**, **estoque**, **clientes**, **vendas**, **fornecedores**, entre outros elementos essenciais para o funcionamento do negócio.

## 📦 Entidades Principais

### 👕 Produtos
- Código único, nome, descrição, preço, tamanho, cor, marca.
- Relacionado a uma **categoria** e a um **fornecedor**.

### 🗂️ Categorias de Produtos
- Organiza os produtos em grupos como: **Feminino**, **Masculino**, **Infantil**.
- Contém um código e nome da categoria.

### 📦 Estoque
- Controla a **quantidade disponível** de cada produto.
- Registra **data de entrada**, **data de saída** e o **produto relacionado**.

### 🚚 Fornecedores
- Empresas que fornecem os produtos para a loja.
- Informações: código, nome, telefone, e-mail e endereço.

### 🧍 Clientes
- Pessoas que compram na loja.
- Cada cliente possui código, nome, telefone(s), e-mail e endereço.

### 🧾 Vendas
- Registro das compras realizadas.
- Inclui: código, data/hora, valor total, status (concluída ou não), forma de pagamento, cliente e vendedor envolvidos.

### 📄 Itens da Venda
- Detalha os produtos comprados em cada venda.
- Informa: produto, quantidade e preço unitário no momento da compra.

### 👨‍💼 Funcionários e Vendedores
- Funcionários possuem: código, nome, cargo, salário, contatos.
- Vendedores são um tipo de funcionário com **comissão**.

### 🏷️ Promoções
- Ofertas e descontos.
- Atributos: código, nome, descrição, valor do desconto, tipo, datas de início/fim, status.

### 🔗 Produtos em Promoção
- Relação entre produtos e promoções.
- Informa o **preço promocional** e a **quantidade disponível** para a promoção.

---

## 🔄 Relacionamentos

- Um **produto** pertence a uma **categoria** e é fornecido por um **fornecedor**.
- O **estoque** controla entradas e saídas de **produtos**.
- Uma **venda** é feita por um **cliente** e registrada por um **vendedor**.
- Uma **venda** contém vários **itens da venda** (produtos comprados).
- **Promoções** afetam determinados **produtos**, criando os **produtos em promoção**.

---

## 📌 Regras de Negócio

- **Controle de Estoque**: Monitoramento de entrada/saída de produtos e alertas de baixo estoque.
- **Registro Detalhado de Vendas**: Dados completos sobre clientes, produtos, pagamentos e vendedores.
- **Gestão de Promoções**: Administração de promoções ativas e aplicação de descontos nos produtos.
- **Cadastro de Clientes e Fornecedores**: Informações sempre atualizadas, com suporte a múltiplos telefones.
- **Análises e Relatórios**: 
  - Produtos mais vendidos
  - Performance dos vendedores
  - Produtos parados no estoque

---

## 🛠️ Scripts Incluídos

- `CREATE` (DDL): Estrutura do banco de dados
- `INSERT` (DML): Dados de exemplo
- `SELECT` (DQL): Consultas para relatórios
- `UPDATE` e `DELETE`: Atualizações e remoções
- `VIEWS`: Visões para facilitar análises
- `ALTER` e `DROP`: Modificações de estrutura

---

## 📊 Modelo Conceitual

![Modelo ER](img/ModeloConceitual

## 📊 Modelo Lógico

![Modelo MR](img/lojaRoupa-ModeloLógico

