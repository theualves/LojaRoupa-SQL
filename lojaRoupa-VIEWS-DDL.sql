-- 1. Ranking de Vendedores por Volume de Vendas no Último Mês
CREATE OR REPLACE VIEW `vw_RankingVendedoresUltimoMes` AS
SELECT 
    f.nome AS `Nome do Vendedor`,
    CONCAT('R$ ', FORMAT(SUM(v.valorTotal), 2, 'de_DE')) AS `Volume de Vendas`
FROM Funcionario f
INNER JOIN Vendedor ven ON f.idFuncionario = ven.Funcionario_idFuncionario
INNER JOIN vendas v ON ven.Funcionario_idFuncionario = v.Vendedor_Funcionario_idFuncionario
WHERE v.dataVenda >= CURDATE() - INTERVAL 1 MONTH
GROUP BY f.nome
ORDER BY SUM(v.valorTotal) DESC;

SELECT * FROM vw_RankingVendedoresUltimoMes;


-- 2. Clientes com Compras Acima de R$ 500,00 no Total
CREATE OR REPLACE VIEW `vw_ClientesMaioresCompradores` AS
SELECT 
    c.nomeCliente AS `Nome do Cliente`,
    SUM(vp.qtd) AS `Quantidade de Itens Comprados`,
    CONCAT('R$ ', FORMAT(SUM(v.valorTotal), 2, 'de_DE')) AS `Valor Total Comprado`
FROM vendas v
INNER JOIN Clientes c ON v.Clientes_idCliente = c.idCliente
INNER JOIN vendasProduto vp ON vp.Vendas_idVendas = v.idVendas
WHERE v.valorTotal > 500.00
GROUP BY c.nomeCliente;

SELECT * FROM vw_ClientesMaioresCompradores;


-- 3. Ticket Médio por Cliente nos Últimos 3 Meses
CREATE OR REPLACE VIEW `vw_TicketMedioClienteUltimos3Meses` AS
SELECT 
    c.nomeCliente AS `Nome do Cliente`,
    CONCAT('R$ ', FORMAT(AVG(v.valorTotal), 2, 'de_DE')) AS `Ticket Médio`
FROM Clientes c
INNER JOIN vendas v ON v.Clientes_idCliente = c.idCliente
WHERE v.dataVenda >= CURDATE() - INTERVAL 3 MONTH
GROUP BY c.idCliente;

SELECT * FROM vw_TicketMedioClienteUltimos3Meses;


-- 4. Ranking de Vendas (em Valor) por Categoria de Produto
CREATE OR REPLACE VIEW `vw_ValorTotalVendasPorCategoria` AS
SELECT 
    cp.nomeCategoria AS `Categoria`,
    CONCAT('R$ ', FORMAT(SUM(vp.precoUn * vp.qtd), 2, 'de_DE')) AS `Valor Total Vendido`
FROM CategoriaProdutos cp
INNER JOIN Produtos p ON cp.idCategoria = p.CategoriaProdutos_idCategoria
INNER JOIN vendasProduto vp ON p.idProduto = vp.Produtos_idProduto
INNER JOIN vendas v ON vp.Vendas_idVendas = v.idVendas
WHERE v.status = 'Concluída'
GROUP BY cp.idCategoria, cp.nomeCategoria
ORDER BY SUM(vp.precoUn * vp.qtd) DESC;

SELECT * FROM vw_ValorTotalVendasPorCategoria;


-- 5. Produtos com Estoque Crítico (Abaixo de 30 Unidades)
CREATE OR REPLACE VIEW `vw_EstoqueCritico` AS
SELECT 
    p.nome AS `Nome do Produto`,
    e.quantidade AS `Quantidade em Estoque`,
    f.nomeFornecedor AS `Fornecedor`
FROM Produtos p
INNER JOIN Estoque e ON p.idProduto = e.Produtos_idProduto
INNER JOIN Fornecedor f ON p.Fornecedor_idFornecedor = f.idFornecedor
WHERE e.quantidade < 30;

SELECT * FROM vw_EstoqueCritico;


-- 6. Resumo Diário de Vendas (Faturamento e N° de Transações)
CREATE OR REPLACE VIEW `vw_ResumoDiarioVendas` AS
SELECT
    ANY_VALUE(DATE_FORMAT(DATE(dataVenda), '%d/%m/%Y')) AS `Data`,
    CONCAT('R$ ', FORMAT(SUM(valorTotal), 2, 'de_DE')) AS `Faturamento Total`,
    COUNT(idVendas) AS `Número de Vendas`
FROM vendas
WHERE status = 'Concluída'
GROUP BY DATE(dataVenda)
ORDER BY DATE(dataVenda) DESC;

SELECT * FROM vw_ResumoDiarioVendas;


-- 7. Promoções Ativas e os Produtos Associados
CREATE OR REPLACE VIEW `vw_PromocoesAtivasComProdutos` AS
SELECT 
    pr.nomePromocao AS `Nome da Promoção`,
    p.nome AS `Produto em Promoção`,
    CONCAT('R$ ', FORMAT(p.preco, 2, 'de_DE')) AS `Preço Original`,
    -- Correção: Trocando 'preco UN' por 'preco_UN'
    CONCAT('R$ ', FORMAT(pd.`Preco Un`, 2, 'de_DE')) AS `Preço com Desconto`
FROM Promocoes pr
INNER JOIN ProdutoDescontado pd ON pr.idPromocao = pd.Promocoes_idPromocao
INNER JOIN Produtos p ON pd.Produtos_idProduto = p.idProduto
WHERE pr.status = 'ativo';

select * from produtoDescontado;
SELECT * FROM vw_PromocoesAtivasComProdutos;


-- 8. Produtos com Menor Saída nos Últimos 3 Meses
CREATE OR REPLACE VIEW `vw_ProdutosMenosVendidosUltimos3Meses` AS
SELECT 
    p.nome AS `Nome do Produto`,
    SUM(COALESCE(vp.qtd, 0)) AS `Qtd Total Vendida`
FROM Produtos p
LEFT JOIN vendasProduto vp ON vp.Produtos_idProduto = p.idProduto
LEFT JOIN vendas v ON vp.Vendas_idVendas = v.idVendas AND v.dataVenda >= CURDATE() - INTERVAL 3 MONTH
GROUP BY p.idProduto
ORDER BY `Qtd Total Vendida` ASC;

SELECT * FROM vw_ProdutosMenosVendidosUltimos3Meses;


-- 9. Média de Preço dos Produtos por Categoria
CREATE OR REPLACE VIEW `vw_PrecoMedioPorCategoria` AS
SELECT 
    cp.nomeCategoria AS `Categoria`,
    CONCAT('R$ ', FORMAT(AVG(p.preco), 2, 'de_DE')) AS `Preço Médio`
FROM CategoriaProdutos cp
INNER JOIN Produtos p ON cp.idCategoria = p.CategoriaProdutos_idCategoria
GROUP BY cp.nomeCategoria;

SELECT * FROM vw_PrecoMedioPorCategoria;


-- 10. Fornecedores que Atendem a Múltiplas Categorias
CREATE OR REPLACE VIEW `vw_FornecedoresMultiCategoria` AS
SELECT 
    f.nomeFornecedor AS `Nome do Fornecedor`,
    COUNT(DISTINCT cp.idCategoria) AS `Número de Categorias Fornecidas`
FROM Fornecedor f
INNER JOIN Produtos p ON f.idFornecedor = p.Fornecedor_idFornecedor
INNER JOIN CategoriaProdutos cp ON p.CategoriaProdutos_idCategoria = cp.idCategoria
GROUP BY f.nomeFornecedor
HAVING COUNT(DISTINCT cp.idCategoria) > 1;

SELECT * FROM vw_FornecedoresMultiCategoria;