pkgs <-c('shiny','evaluate','formatR','GGally','ggplot2','googleVis','mlbench','rCharts','caret')
 lapply(pkgs,require, character.only =T)
 library(caret)
data("PimaIndiansDiabetes")
Data  <- as.data.frame(PimaIndiansDiabetes)
intrain<-createDataPartition(Data$diabetes ,  p = .7,list = F)
train<- Data[intrain,]
test<- as.data.frame( Data[-intrain,])
PCA<- princomp(train[,1:8],cor = T) # PCA ANALYSIS drop of outcome factor
X<- as.data.frame(PCA$scores)       # probality scores 
X<- as.data.frame(cbind(X,train$diabetes)) 
names(X)[9] = "diabetes"
 ax<- "p"
loop<-function( x,y){
               x<-  isolate(x()) ;    y<-isolate(y())
                 x[y>.50]= "pos"
                 
                 
                    x <- na.omit(x)
                        return(x)      
                      
                        }
