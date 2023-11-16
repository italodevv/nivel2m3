SELECT 
	idpessoa, 
	nome, 
	logradouro, 
	cidade, 
	estado, 
	telefone, 
	email, 
	Pessoa_idPessoa, 
	cpf 
FROM
	dbo.Pessoa
INNER JOIN
	dbo.PessoaFisica ON dbo.Pessoa.idPessoa = dbo.PessoaFisica.Pessoa_idPessoa
WHERE
	idpessoa = Pessoa_idPessoa

SELECT
	idpessoa, 
	nome, 
	logradouro, 
	cidade, 
	estado, 
	telefone, 
	email, 
	Pessoa_idPessoa, 
	cnpj 
FROM
	dbo.Pessoa
INNER JOIN
	dbo.PessoaJuridica ON dbo.Pessoa.idPessoa = dbo.PessoaJuridica.Pessoa_idPessoa
WHERE 
	idPessoa = Pessoa_idPessoa

SELECT
    mov.tipo AS TIPO_MOVIMENTA��O,
    pro.nome AS PRODUTO,
	pes.nome AS FORNECEDOR,
    mov.quantidade AS QUANTIDADE,
    mov.valorUnitario AS VALOR_UNIT�RIO,
    (mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
	dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
	dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    tipo = 'E';


SELECT
    mov.tipo AS TIPO_MOVIMENTA��O,
    pro.nome AS PRODUTO,
	pes.nome AS COMPRADOR,
    mov.quantidade AS QUANTIDADE,
    mov.valorUnitario AS VALOR_UNIT�RIO,
    (mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
	dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
	dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    tipo = 'S';


SELECT
    pro.nome AS PRODUTO_ENTRADA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'E'
GROUP BY
    pro.nome


SELECT
    pro.nome AS PRODUTO_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'S'
GROUP BY
    pro.nome


SELECT
	usu.login AS OPERADOR
FROM
	dbo.Usuario AS usu
WHERE
    NOT EXISTS (
        SELECT 1
        FROM
            dbo.Movimento AS mov
        WHERE
            mov.Usuario_idUsuario = usu.idUsuario
            AND mov.tipo = 'E'
    );


SELECT
    usu.login AS OPERADOR_ENTRADA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Usuario AS usu ON mov.Usuario_idUsuario = usu.idUsuario
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto

WHERE
    mov.tipo = 'E'
GROUP BY
    usu.login


SELECT
    usu.login AS OPERADOR_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Usuario AS usu ON mov.Usuario_idUsuario = usu.idUsuario
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto

WHERE
    mov.tipo = 'S'
GROUP BY
    usu.login


SELECT
    pro.nome AS PRODUTO_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario)/SUM(mov.quantidade) AS              VALOR_PONDERADO,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'S'
GROUP BY
    pro.nome
