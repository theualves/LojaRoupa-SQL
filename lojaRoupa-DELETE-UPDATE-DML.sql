UPDATE Produtos
SET preco = 349.99
WHERE idProduto = 2;
SELECT * FROM Produtos WHERE idProduto = 2;

DELETE FROM Promocoes
WHERE idPromocao = 3;
SELECT * FROM Promocoes WHERE idPromocao = 3;

UPDATE Promocoes
SET descricao = "Presentes especiais com 25% de desconto"
WHERE idPromocao = 4;
SELECT * FROM Promocoes WHERE idPromocao = 4;

UPDATE Promocoes
SET valorDesconto = 25.00
WHERE idPromocao = 4;
SELECT * FROM Promocoes WHERE idPromocao = 4;

UPDATE Clientes
SET nomeCliente = 'Larissa Alves'
WHERE idCliente = 14;
SELECT * FROM Clientes WHERE idCliente = 14;

UPDATE TelefoneFornecedor
SET numero = "(11) 3344-1234"
WHERE Fornecedor_idFornecedor = 7;
SELECT * FROM TelefoneFornecedor WHERE Fornecedor_idFornecedor = 7;

DELETE FROM TelefoneFornecedor
WHERE Fornecedor_idFornecedor = 9;
SELECT * FROM TelefoneFornecedor WHERE Fornecedor_idFornecedor = 9;

UPDATE Vendedor
SET comissao = 8.00
WHERE Funcionario_idFuncionario = 1;
SELECT * FROM Vendedor WHERE Funcionario_idFuncionario = 1;

UPDATE Funcionario
SET salario = 3200.00
WHERE idFuncionario = 5;
SELECT * FROM Funcionario WHERE idFuncionario = 5;

UPDATE Funcionario
SET nome = "Alexandre de Moraes"
WHERE idFuncionario = 14;
SELECT * FROM Funcionario WHERE idFuncionario = 14;

DELETE FROM Funcionario
WHERE idFuncionario = 16;
SELECT * FROM Funcionario WHERE idFuncionario = 16;

UPDATE Estoque
SET quantidade = 80
WHERE Produtos_idProduto = 11;
SELECT * FROM Estoque WHERE Produtos_idProduto = 11;

DELETE FROM Estoque
WHERE Produtos_idProduto = 7;
SELECT * FROM Estoque WHERE Produtos_idProduto = 7;

UPDATE Fornecedor
SET email = 'pedido@sportwearinc.com'
WHERE idFornecedor = 5;
SELECT * FROM Fornecedor WHERE idFornecedor = 5;

UPDATE Fornecedor
SET nomeFornecedor = 'Atacadão das roupas'
WHERE idFornecedor = 10;
SELECT * FROM Fornecedor WHERE idFornecedor = 10;

UPDATE Fornecedor
SET nomeFornecedor = 'AlgoPlus'
WHERE idFornecedor = 15;
SELECT * FROM Fornecedor WHERE idFornecedor = 15;

DELETE FROM Fornecedor
WHERE idFornecedor = 17;
SELECT * FROM Fornecedor WHERE idFornecedor = 17;

UPDATE enderecocliente
SET rua = 'Avenida Brigadeiro Luís Antônio', cep = '01317-002'
WHERE Clientes_idCliente = 7;
SELECT * FROM enderecocliente WHERE Clientes_idCliente = 7;

UPDATE promocoes
SET status = 'inativo'
WHERE nomePromocao = 'Leve 3 Pague 2 - Básicos';
SELECT * FROM promocoes WHERE nomePromocao = 'Leve 3 Pague 2 - Básicos';
SET SQL_SAFE_UPDATES = 0;


UPDATE funcionario
SET cargo = 'Supervisor de Vendas', salario = 3800.00
WHERE idFuncionario = 2;
SELECT * FROM funcionario WHERE idFuncionario = 2;

DELETE FROM telefonecliente
WHERE Clientes_idCliente = 10;
SELECT * FROM telefonecliente WHERE Clientes_idCliente = 10;

-- Este SELECT final mostrará o estado da tabela inteira após a exclusão
SELECT * FROM telefonecliente;