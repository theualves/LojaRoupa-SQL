

ALTER TABLE `Clientes` 
ADD COLUMN `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo';

select * from produtodescontado;
ALTER TABLE `produtodescontado`
RENAME COLUMN `preco UN` to `Preço Unitário`;

select * from produtodescontado;
ALTER TABLE `produtodescontado`
RENAME COLUMN `qtd` to `quantidade`;

select * from enderecofornecedor;
ALTER TABLE `enderecofornecedor`
Drop Column complemento;

ALTER TABLE `enderecofornecedor`
RENAME COLUMN `UF` to `unidades federativas`;

select * from produtos;
ALTER TABLE `produtos`
DROP COLUMN `descrição`;

select * from vendas;
ALTER TABLE `vendas`
RENAME COLUMN `Vendedor_Funcionario_idFuncionario` to `ID do Funcionário`;

ALTER TABLE `vendas`
RENAME COLUMN `Clientes_idCliente` to `ID do Cliente`;

select * from promocoes;
ALTER TABLE `promocoes`
DROP COLUMN `descricao`;

select * from enderecocliente;
ALTER TABLE `enderecocliente`
Drop COLUMN `complemento`











