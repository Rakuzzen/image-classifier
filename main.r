library(EBImage)
library(keras)

#Retorna um array com as imagens redimensionadas
getImageArray <- function(dir, pics, i){
  images <- list()
  #Define o caminho da imagem
  path <- paste(dir, pics[i], sep = "")
  #Pega a imagem
  images[[i]] <- readImage(path)
  #Redimensionando imagem
  images[[i]] <- resize(images[[i]], 28, 28)
  #Alterando shape da imagem
  images[[i]] <- array_reshape(images[[i]], c(28, 28, 3))
    
  return(images)
}

#300 cat images
#300 dog images

#Lista de imagem de treijp
cat_and_dog_names <- list.files(path = 'train/', pattern = "*.jpg")
#Lista de imagem de teste
test_names <- list.files(path = 'test/', pattern = "*.jpg")

train_images <- list()
test_images <- list()

trainx <- NULL
testx <- NULL
trainy <- NULL
#Armazenando as respostas corretas das imagens de teste (0 gato, 1 cachorro)
testy <- c(1,1,1,1,0,0,0,0,0,0,
           0,1,0,0,0,0,1,1,0,0,
           1,0,1,1,0,1,1,0,0,1,
           1,0,1)

#Criando barra de progressos
progress_bar <- winProgressBar(title = "Get_image_array", min = 0, 
                               max = length(cat_and_dog_names), width = 300)

for(i in 1:length(cat_and_dog_names)){
  #Array com as imagens
  train_images <- getImageArray('train/',cat_and_dog_names,i)
  #Tranforma as imagens de treino em um vetor
  trainx <- rbind(trainx, train_images[[i]])
  #Transform as imagens de teste em um vetor
  if(i <= length(test_names)){ 
    test_images <- getImageArray('test/',test_names, i)
    testx <- rbind(testx, test_images[[i]]) 
  }
  #Gera as 300 primeiras respostas (Gatos)
  if(i <= length(cat_and_dog_names) / 2) trainy <- c(trainy,0)
  #Gera as 300 ultimas respostas (Cachorros)
  else trainy <- c(trainy,1)
  #Executando barra de progressos
  setWinProgressBar(progress_bar, i, title=paste(round(i/length(cat_and_dog_names)*100, 0),"% done"))
}

close(progress_bar)
#Criando labels para treinamento
trainLabels <- to_categorical(trainy)
#Criando labels para teste
testLabels <- to_categorical(testy)
#Criando modelo
model <- keras_model_sequential()

model %>%
  #Definando neurônio da primeira camada e shape do input (2352 = 28*28*3)
  layer_dense(units = 256, activation = 'relu', input_shape = c(2352)) %>%
  layer_dense(units = 128, activation = 'relu') %>%
  #Neurônio de saída (2 saídas possíveis, gato ou cachorro)
  layer_dense(units = 2, activation = 'softmax')

summary(model)

model %>%
  #Compilando modelo
  compile(loss = 'binary_crossentropy',
          optimizer = optimizer_rmsprop(),
          metrics = 'accuracy')

history <- model %>%
  fit(trainx,
      trainLabels,
      epochs = 33,
      batch_size = 32,
      validation_split = 0.3)

plot(history)

#Avalia os dados de treinamento
model %>% evaluate(trainx, trainLabels)
#Realiza previsões dos dados de treinamento
train_pred <- model %>% predict_classes(trainx)
#Retorna a probabilidade de ser uma coisa ou outra
train_probability <- model %>% predict_proba(trainx)
#Retorna a probabilidade de ser uma classe ou outra, a previsão e a resposta correta
cbind(train_probability, Predicted = train_pred, Correct = trainy)


#Avalia os dados de teste
model %>% evaluate(testx, testLabels)
#Realiza previsões dos dados de teste
test_pred <- model %>% predict_classes(testx)
#Retorna a probabilidade de ser uma coisa ou outra
test_probability <- model %>% predict_proba(testx)
#Retorna a probabilidade de ser uma classe ou outra, a previsão e a resposta correta
cbind(test_probability, Predicted = test_pred, Correct = testy)

