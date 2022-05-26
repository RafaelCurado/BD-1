# Lab05

## Grupo - **P2G2**

| Membros | Número Mecanográfico |
| :- | :-: |
| David Araújo | 93444 |
| Miguel Nogueira | 93082 |

## Exercício 7.2

### a)

Uma vez que todos os **atributos são atómicos** nem existem *nested relations*. e não pedendo ser 2FN devido à existência de **dependências parciais**, esta relação é **1FN**.

### b)

Remover as dependência parciais obtemos a seguinte decomposição:

### R1(**Titulo_Livro**, **Nome_Autor**, Tipo_Livro, Preco, NoPaginas, Editor, Endereco_Editor, Ano_Publicacao)

- Titulo_Livro, Nome_Autor -> Editor, Tipo_Livro, NoPaginas, Ano_Publicacao
- Tipo_Livro, NoPaginas -> Preco
- Editor -> Endereco_Editor

### R2(**Nome_Autor**, Afiliacao_Autor)
- Nome_Autor -> Afiliacao_Autor

Agora decomposto, ainda obtemos dependências transistivas que têm de ser descompostas, obtendo:

### R1(**Titulo_Livro**, **Nome_Autor**, Tipo_Livro, NoPaginas, Editor, Ano_Publicacao)
- Titulo_Livro, Nome_Autor -> Tipo_Livro, NoPaginas, Editor, Ano_Publicacao

### R2(**Tipo_Livro**, **NoPaginas**, Preco)
- Tipo_Livro, NoPaginas -> Preco

### R3(**Editor**, Endereco_Editor)
- Editor -> Endereco_Editor

### R4(**Nome_autor**, Afiliacao_Autor)
- Nome_autor -> Afiliacao_Autor

<div style="page-break-after: always;"></div>

## Exercício 7.3

### a)
