# Lab05

## Grupo - **P2G2**

| Membros | Número Mecanográfico |
| :- | :-: |
| David Araújo | 93444 |
| Miguel Nogueira | 93082 |

## Exercício 7.2

### a)

Uma vez que todos os **atributos são atómicos** nem existem *nested relations*. e não pedendo ser 2FN devido à existência de **dependências parciais**, esta relação é **1FN**.

<<<<<<< HEAD
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
=======
### b) 

Para normalizar para 2FN, qualquer dependência parcial tem de ser removida, obtendo:

- R1(**Titulo__Livro**, **Nome_autor**, Editor, Tipo_Livro, NoPaginas, Ano_Publicacao)
  - Titulo_Livro, Nome_Autor -> Editor, Tipo_Livro, NoPaginas, Ano_Publicacao
  - Tipo_Livro, NoPaginas -> Preco
  - Editor -> Endereco_Editor
- R2(**Nome_Autor**, Afiliacao_Autor)
  - Nome_Autor -> Afiliacao_Autor

Agora, para normalizar para a 3FN é também necessário remover todas as dependência transitivas.

- R1(**Titulo__Livro**, **Nome_autor**, Editor, Tipo_Livro, NoPaginas, Ano_Publicacao)
  - Titulo_Livro, Nome_Autor -> Editor, Tipo_Livro, NoPaginas, Ano_Publicacao
- R2(**Tipo_Livro**,**NoPaginas**, Preco)
  - Tipo_Livro, NoPaginas -> Preco
- R3(**Editor**, Endereco_Editor)
  - Editor -> Enderco_Editor
- R4(**Nome_Autor**, Afiliacao_Autor)
  - Nome_Autor -> Afiliacao_Autor

<div style="page-break-after: always;"></div>

## Exercício 7.3

### a)
Chaves Candidatas:
- {A,B};
- {A};
- {B};
- {D};
- {F}.

Chave de R:
- {A,B}

### b)

Uma vez que é para transformar em 2FN apenas temos de remover as dependências parciais podendo deixar as transitivas.

- R(**A**,**B**,C)
  - A, B -> {C}
- R2(**A**,D,E,I,J)
  - A -> D, E
  - D -> I, J
- R3(**B**,F,G,H)
  - B -> F
  - F -> G, H

### c)

Agora sim, teremos de remover as dependências transitivas

- R1(**A**,**B**,C)
  - A, B -> C
- R2(**A**,D,E)
  - A -> D, E
- R3(**D**,I,J)
  - D -> I, J
- R4(**B**,F)
  - B -> F
- R5(**F**,G,H)
  - F -> G, H

<div style="page-break-after: always;"></div>

## Exercício 7.4

### a)

Chaves candidatas:
- {A,B};
- {A};
- {C}.

Chave:
- {A,B}.

### b)

A relação já se encontra na 3FN pois a chave já define todos os outros atributos.

### c)

Todos os atributos devem ser totalmente dependentes da chave e nada mais pelo que:
 
- R1(**B**,C,D)
  - B -> C, D
- R2(**D**,E)
  - B -> E
- R3(C,A)
  - C -> A

## Exercício 7.5

### a)

Chaves Candidatas:
- {A,B};
- {A};
- {C};

Chave:
- {A,B}

### b) & c)
A relação já se encontra na 3FN pois a chave já define todos os atributos restantes.

<div style="page-break-after: always;"></div>

### d)

- R1(**A**,B,E)
  - A -> B, E
- R2(**A**,C)
  - A -> C
- R3(**C**, D)
  - C -> D
- R4(**A**, D)
  - A -> D
>>>>>>> 5a90f8b2d84d4d30b9aa53ad15d4e9f710ecf80b
