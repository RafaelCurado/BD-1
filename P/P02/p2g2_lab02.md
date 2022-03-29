# Aula Prática 02

## Membros - <u>P2G2</u>

| Nome | Número Mecanográfico |
| - | - |
| David Araújo| 93444 |
| Miguel Nogueira| 93082 |


# Exercícios 2.1

## a)

| Entidade | Atributos |
| - | - |
| Empresa | Nome <br> NIF |
| Produto | Código <br> Preço <br> Nome <br> Taxa IVA |
| Encomenda | Número <br> Data |
| Fornecedor | NIF <br> Nome <br> Endereço <br> Fax <br> Pagamento <br> Código |

## b)

| Relação | Grau | Cardinalidade | Obrigatoriedade de Participação |
| - | :-: | :-: | :-: |
| Empresa - Produto | 2 | 1:N | Produto  |
| Produto - Encomenda | 2 | M:N | Encomenda |
| Encomenda - Forncedor | 2 | N:1 | Encomenda |