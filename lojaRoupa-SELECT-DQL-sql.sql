-- 1. Quantidade de pedidos e data de compra dos clientes nos últimos 30 dias

select clientes.nomeCliente "Nome do Cliente", count(vendasProduto.qtd) "Quantidade de Pedidos", date_format(vendas.dataVenda, '%d/%m/%Y') "Data de Compra"
from vendasProduto
left join vendas on vendasProduto.vendas_idVendas = vendas.idVendas
left join clientes on vendas.clientes_idCliente = clientes.idCliente
where timestampdiff(day, vendas.dataVenda, now()) < 31
group by nomeCliente, vendas.dataVenda;

-- 2. Qual o ticket médio de cada cliente nos 3 últimos meses?

select clientes.nomeCliente "Nome do Cliente", concat('R$ ', format(avg(vendas.valorTotal), 2, 'de_DE')) "Ticket Médio"
from clientes
inner join vendas on vendas.clientes_idCliente = clientes.idCliente
group by clientes.idCliente;

-- 3. Quais clientes compraram mais de R$ 500,00 no total?

select clientes.nomeCliente "Nome do Cliente", vendasproduto.qtd "Quantidade de Itens Comprados", concat('R$ ', format(vendas.valorTotal, 2, 'de_DE')) "Valor Total Comprado" 
from vendas
inner join clientes on vendas.clientes_idCliente = clientes.idCliente
inner join vendasproduto on vendasproduto.vendas_idVendas = vendas.idVendas
where vendas.valorTotal > 500.00;

-- 4. Qual o produto mais vendido da loja com o pagamento cartão?

select produtos.idProduto "ID do Produto", produtos.nome "Produto Vendido", 
produtos.descricao "Descrição do Produto", concat('R$ ', format(produtos.preco, 2, 'de_DE')) "Preço do Produto", 
vendas.formaPagamento "Forma de Pagamento", sum(vendasProduto.qtd) "Quantidade Vendida"
from produtos
inner join vendasProduto on vendasProduto.produtos_idProduto = produtos.idProduto
inner join vendas on vendasProduto.vendas_idVendas = vendas.idVendas
where vendas.status = "Concluída" and vendas.formaPagamento like "Cartão%"
group by produtos.idProduto, vendas.formaPagamento
order by produtos.idProduto;

-- 5. Produtos que entraram no Estoque nos últimos 6 meses

select produtos.idProduto "ID do Produto", produtos.nome "Nome do Produto",
produtos.descricao "Descrição do Produto", estoque.quantidade "Quantidade", concat('R$', format(produtos.preco, 2, 'de_DE')) "Preço do Produto",
date_format(estoque.dataEntrada, '%d/%m/%Y') "Data de Entrada"
from produtos
inner join estoque on estoque.produtos_idProduto = produtos.idProduto
where timestampdiff(month, estoque.dataEntrada, curdate()) <= 6;

-- 6. Quantidade e valor total de produtos adquirido por cada fornecedor em 3 meses?

select fornecedor.nomeFornecedor "Fornecedor", enderecoFornecedor.cidade "Origem",
estoque.quantidade "Qtd de Produtos Fornecidos", concat('R$ ', format(estoque.quantidade * vendasProduto.precoUn, 2, 'de_DE')) "Valor Total",
produtos.nome "Produto fornecido"
from fornecedor -- adicionar o produto fornecido
inner join produtos on produtos.fornecedor_idFornecedor = fornecedor.idFornecedor
inner join vendasProduto on vendasProduto.produtos_idProduto = produtos.idProduto
inner join enderecoFornecedor on enderecoFornecedor.fornecedor_idFornecedor = fornecedor.idFornecedor
inner join estoque on estoque.produtos_idProduto = produtos.idProduto;

-- 7. Quantidade de produtos vendidos por cada vendedor

select funcionario.nome "Nome do Funcionário", concat(coalesce(sum(vendasProduto.qtd), 0), ' Produtos') "Qtd de Produtos Vendidos"
from funcionario
inner join vendedor on vendedor.Funcionario_idFuncionario = funcionario.idFuncionario
left join vendas on vendas.Vendedor_Funcionario_idFuncionario = vendedor.Funcionario_idFuncionario
left join vendasproduto on vendasProduto.Vendas_idVendas = vendas.idVendas
group by funcionario.idFuncionario;

-- 8. Produtos com menor saída nos últimos 3 meses

select produtos.nome "Nome do Produto", sum(vendasProduto.qtd) "Qtd Total Vendida"
from produtos
left join vendasProduto on vendasProduto.produtos_idProduto = produtos.idProduto
left join vendas on vendasProduto.vendas_idVendas = vendas.idVendas
where timestampdiff(month, vendas.dataVenda, now()) <= 3
group by produtos.idProduto;

-- 9. Produtos com maior quantidade em estoque e seu respectivo fornecedor

select produtos.nome "Nome do Produto", estoque.quantidade "Quantidade em Estoque", fornecedor.nomeFornecedor "Fornecedor"
from produtos
inner join Estoque on produtos.idProduto = estoque.Produtos_idProduto
inner join Fornecedor on produtos.Fornecedor_idFornecedor = fornecedor.idFornecedor;

-- 10. Fornecedores que fornecem produtos para mais de uma categoria

select fornecedor.nomeFornecedor "Nome do Fornecedor", count(categoriaProdutos.nomeCategoria) "Número de Categorias Fornecidas"
from fornecedor
inner join Produtos on fornecedor.idFornecedor = produtos.Fornecedor_idFornecedor
inner join CategoriaProdutos on produtos.CategoriaProdutos_idCategoria = categoriaProdutos.idCategoria
group by fornecedor.nomeFornecedor
having count(categoriaProdutos.nomeCategoria) > 1;

-- 11. Clientes que compraram produtos em promoção e o valor total economizado

select clientes.nomeCliente "Nome do Cliente",
    concat('R$ ', format(sum(produtoDescontado.`preco UN` * produtoDescontado.qtd), 2, 'de_DE')) "Valor Total Pago",
    concat('R$ ', format(sum(produtos.preco * produtoDescontado.qtd) - sum(produtoDescontado.`preco UN` * produtoDescontado.qtd), 2, 'de_DE')) "Economia Total"
from clientes
inner join vendas on clientes.idCliente = vendas.Clientes_idCliente
inner join vendasProduto vendasProduto on vendas.idVendas = vendasProduto.Vendas_idVendas
inner join produtos on vendasProduto.Produtos_idProduto = produtos.idProduto
join produtoDescontado on produtos.idProduto = produtoDescontado.Produtos_idProduto
where produtoDescontado.Promocoes_idPromocao is not null
group by clientes.nomeCliente
having sum(produtos.preco * produtoDescontado.qtd) - sum(produtoDescontado.`preco UN` * produtoDescontado.qtd) > 0;

-- 12. Média de preço dos produtos por categoria

select categoriaProdutos.nomeCategoria "Categoria", concat('R$ ', format(avg(produtos.preco), 2, 'de_DE')) "Preço Médio"
from categoriaProdutos
inner join produtos on categoriaProdutos.idCategoria = produtos.CategoriaProdutos_idCategoria
group by categoriaProdutos.nomeCategoria;

-- 13. Vendedores com maior volume de vendas (em valor) no último mês

select funcionario.nome "Nome do Vendedor", concat('R$ ', format(sum(vendas.valorTotal), 2, 'de_DE')) "Volume de Vendas"
from funcionario
inner join vendedor on funcionario.idFuncionario = vendedor.Funcionario_idFuncionario
inner join vendas on vendedor.Funcionario_idFuncionario = vendas.Vendedor_Funcionario_idFuncionario
where timestampdiff(month, vendas.dataVenda, now()) <= 1
group by funcionario.nome
order by "Volume de Vendas" DESC;

-- 14. Produtos que nunca foram vendidos

select produtos.nome "Nome do Produto", produtos.descricao "Descrição"
from produtos
left join vendasProduto on produtos.idProduto = vendasProduto.Produtos_idProduto
where vendasProduto.Produtos_idProduto is null;

-- 15. Clientes que possuem mais de um telefone cadastrado

select clientes.nomeCliente "Nome do Cliente", count(telefoneCliente.idTelefone) "Número de Telefones"
from clientes
inner join telefoneCliente on clientes.idCliente = telefoneCliente.Clientes_idCliente
group by clientes.nomeCliente
having count(telefoneCliente.idTelefone) > 1;

-- 16. Promoções ativas e os produtos a elas associados

select promocoes.nomePromocao "Nome da Promoção", promocoes.descricao "Descrição da Promoção",
produtos.nome "Produto em Promoção", concat('R$ ', format(produtos.preco, 2, 'de_DE'))
"Preço Original", concat('R$ ', format(produtoDescontado.`preco UN`, 2, 'de_DE')) "Preço com Desconto"
from promocoes
inner join produtoDescontado on promocoes.idPromocao = produtoDescontado.Promocoes_idPromocao
inner join produtos on produtoDescontado.Produtos_idProduto = produtos.idProduto
where promocoes.status = 'ativo';

-- 17. Produtos em estoque que estão atualmente em promoção

select produtos.nome "Nome do Produto",
	concat('R$ ', format(produtos.preco, 2, 'de_DE')) "Preço Original",
	concat('R$ ', format(produtoDescontado.`preco UN`, 2, 'de_DE')) "Preço com Desconto",
	estoque.quantidade "Quantidade em Estoque", promocoes.nomePromocao "Nome da Promoção"
from produtos
inner join estoque on produtos.idProduto = estoque.Produtos_idProduto
inner join produtoDescontado on produtos.idProduto = produtoDescontado.Produtos_idProduto
inner join promocoes on produtoDescontado.Promocoes_idPromocao = promocoes.idPromocao
where promocoes.status = 'ativo'
order by produtos.nome;

-- 18. Produtos com estoque abaixo de um limite mínimo (ex: 30 unidades)
select produtos.nome "Nome do Produto", estoque.quantidade "Quantidade em Estoque", fornecedor.nomeFornecedor "Fornecedor"
from produtos 
inner join estoque on produtos.idProduto = estoque.Produtos_idProduto
inner join fornecedor on produtos.Fornecedor_idFornecedor = fornecedor.idFornecedor
where estoque.quantidade < 30;

-- 19. Fornecedores localizados em uma cidade específica (ex: São Paulo)

select fornecedor.nomeFornecedor "Nome do Fornecedor", enderecoFornecedor.cidade "Cidade", enderecoFornecedor.UF "Estado"
from fornecedor
inner join enderecoFornecedor on fornecedor.idFornecedor = enderecoFornecedor.Fornecedor_idFornecedor
where enderecoFornecedor.cidade = 'São Paulo';

-- 20. Vendas realizadas por funcionários que não são vendedores (ex: Gerente de Loja)

select funcionario.nome "Nome do Funcionário", funcionario.cargo "Cargo", count(vendas.idVendas) "Número de Vendas"
from funcionario
left join vendedor on funcionario.idFuncionario = vendedor.Funcionario_idFuncionario
inner join vendas on funcionario.idFuncionario = vendas.Vendedor_Funcionario_idFuncionario
where vendedor.Funcionario_idFuncionario is null
group by funcionario.nome, funcionario.cargo
having count(vendas.idVendas) > 0;