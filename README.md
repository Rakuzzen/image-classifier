# R Image classifier

Script em R que realiza à classificação de imagens (Gatos e Cachorros)

### Dependências

[**EBImage**](https://www.bioconductor.org/packages/release/bioc/html/EBImage.html) 

Para instalar a biblioteca EBImage execute o seguinte comando no console do R:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EBImage")
```

[**keras**](https://keras.rstudio.com/)

Para instalar a biblioteca keras execute o seguinte comando no console do R:

```
devtools::install_github("rstudio/keras")
```

O keras usa o Tensorflow por trás, para instalar o Keras e o Tensorflow, em seguida execute:

```
install_keras()
```

### Pacote de imagens

Para treinar o modelo foi utilizado um pacote de imagens de gatos e cachorros obtidos na plataforma
[Kaggle](https://www.kaggle.com/c/dogs-vs-cats/data) este pacote possui 12500 imagens para cada animal.

(Recomenda-se utilizar-se menos imagens pois o processamento seria muito demorado)

Os nomes de diretórios usados para armazenar os dados de treino e teste no programa foram por padrão chamados de "train/" e "test/", caso deseje mudar o nome de seus diretórios altere no programa os devidos nomes.

Foi levado em conta também que as imagens para treino teriam a mesma quantidade para gatos e cachorros,
ficando sempre em ordem primeiro todas as imagens de gatos logo em seguida imagens de cashorros, para facilitar ao dar a resposta correta de cada animal.
(Caso contrário a execução falhará)


