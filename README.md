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

