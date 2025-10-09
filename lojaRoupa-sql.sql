-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CategoriaProdutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CategoriaProdutos` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nomeCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `nomeFornecedor` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `tamanho` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `nome` VARCHAR(45) NOT NULL,
  `CategoriaProdutos_idCategoria` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`),
  UNIQUE INDEX `idProduto_UNIQUE` (`idProduto` ASC) VISIBLE,
  INDEX `fk_Produtos_CategoriaProdutos_idx` (`CategoriaProdutos_idCategoria` ASC) VISIBLE,
  INDEX `fk_Produtos_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_CategoriaProdutos`
    FOREIGN KEY (`CategoriaProdutos_idCategoria`)
    REFERENCES `mydb`.`CategoriaProdutos` (`idCategoria`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Produtos_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EnderecoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EnderecoFornecedor` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `UF` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`),
  CONSTRAINT `fk_EnderecoFornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TelefoneFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TelefoneFornecedor` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idTelefone`, `Fornecedor_idFornecedor`),
  INDEX `fk_TelefoneFornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_TelefoneFornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `dataEntrada` DATETIME NOT NULL,
  `dataSaida` DATETIME NOT NULL,
  `Produtos_idProduto` INT NOT NULL,
  PRIMARY KEY (`idEstoque`, `Produtos_idProduto`),
  INDEX `fk_Estoque_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_Produtos1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Promocoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Promocoes` (
  `idPromocao` INT NOT NULL AUTO_INCREMENT,
  `nomePromocao` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `tipoDesconto` VARCHAR(45) NOT NULL,
  `valorDesconto` DECIMAL(6,2) NOT NULL,
  `dataInicio` DATETIME NOT NULL,
  `qtdDias` INT NOT NULL,
  `status` ENUM("ativo", "inativo") NOT NULL,
  PRIMARY KEY (`idPromocao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `contato` VARCHAR(45) NOT NULL,
  `salario` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendedor` (
  `comissao` DECIMAL(7,2) NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`Funcionario_idFuncionario`),
  CONSTRAINT `fk_Vendedor_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `mydb`.`Funcionario` (`idFuncionario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  `formaPagamento` VARCHAR(25) NOT NULL,
  `dataVenda` DATETIME NOT NULL,
  `valorTotal` DECIMAL(6,2) NOT NULL,
  `Vendedor_Funcionario_idFuncionario` INT NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_Vendas_Vendedor1_idx` (`Vendedor_Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Vendas_Clientes1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Vendedor1`
    FOREIGN KEY (`Vendedor_Funcionario_idFuncionario`)
    REFERENCES `mydb`.`Vendedor` (`Funcionario_idFuncionario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Vendas_Clientes1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EnderecoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EnderecoCliente` (
  `rua` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `UF` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`Clientes_idCliente`),
  CONSTRAINT `fk_EnderecoCliente_Clientes1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`TelefoneCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TelefoneCliente` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`idTelefone`, `Clientes_idCliente`),
  INDEX `fk_TelefoneCliente_Clientes1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_TelefoneCliente_Clientes1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendasProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendasProduto` (
  `precoUn` DECIMAL(6,2) NOT NULL,
  `qtd` INT NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  `Produtos_idProduto` INT NOT NULL,
  INDEX `fk_vendasProduto_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  INDEX `fk_vendasProduto_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_vendasProduto_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `mydb`.`Vendas` (`idVendas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendasProduto_Produtos1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProdutoDescontado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProdutoDescontado` (
  `preco UN` DECIMAL(6,2) NOT NULL,
  `qtd` INT NOT NULL,
  `Promocoes_idPromocao` INT NOT NULL,
  `Produtos_idProduto` INT NOT NULL,
  PRIMARY KEY (`Promocoes_idPromocao`, `Produtos_idProduto`),
  INDEX `fk_ProdutoDescontado_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_ProdutoDescontado_Promocoes1`
    FOREIGN KEY (`Promocoes_idPromocao`)
    REFERENCES `mydb`.`Promocoes` (`idPromocao`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ProdutoDescontado_Produtos1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
