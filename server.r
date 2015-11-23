library(shiny)
source("helper.r")
library(xtable)
library(caret)


shinyServer(function(input,output,session){                         #  open server call
 
                 Datasel1 <-reactive({X[ ,c(input$xcol,input$ycol)]})
                 TestSel <- reactive({ test[,c(iput$xcol,input$ycol)]})
                 TestSel <- reactive({  cbind(TestSel,test[,9])})
                 clusters<- reactive({kmeans(Datasel1(),input$clusters)})
                            
  
                  output$plot1 <-renderPlot({
                    par(mar= c(5,4,0,1))
                    plot(Datasel1(),
                    col = clusters()$cluster,pch =20,cex = 3)
                    points(clusters()$centers,pch =4,cex = 4,lwd = 3)
                          }) 
                  
                   Diab   <-reactive({X$diabetes})
                   modfit<- reactive(glm(Diab() ~ Datasel1()[,1] + Datasel1()[,2],family = binomial))
                   modfit.probs <- reactive({predict(modfit(), type='response') }) # as.data.frame(TestSel()),
                   modfit.predict<-reactive({ rep("neg",length(modfit.probs())) })
                   modvector <- reactive({ as.vector(modfit.predict())})
                   modvprob <-  reactive({as.vector(modfit.probs()) })
                                   
                      # x  <- loop(modvector, modvprob)
                    output$table1<- renderTable({summary(modfit()) })    #table(x,train$diabetes)
                    output$table <- renderTable({summary(modfit()) })                      
                     
                   observeEvent(input$Train,
                    output$tablle<- renderDataTable({
                      
                      MOD<-reactive({ glm(diabetes~., family= binomial,data = X)})
                      #PRED <-reactive({predict(MOD(),type = 'response')})
                       Coef<-reactive({ round(summary(MOD())$coeff,6)})
                      #Prob<- reactive({ d()   }) 
                      output$tablle<- renderTable({Coef()})
                      #renderText()
                    }))
                      
   })       # close server 