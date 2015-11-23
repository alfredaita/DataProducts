library(mlbench)
library(shiny)  
source("helper.r")


# pageWithSidebar


shinyUI(fluidPage(
        headerPanel( "Diabetes-Kmeans clustering"),
        
        p("Instructions: The application does clustering on the diabetes set for
          women  Pima indians.  Choose any two variables and select The 
          the cluster counts you desire.The chart displays the results with centerpoints"),
        p("a table is displayed showing the coefficients."),
        p("push the train button and the whole model is trained.And a searchable table is shown "),
        p("To start over press the refresh icon at the browser"),
        
        br(),
         
        sidebarPanel(
           
           selectInput('xcol','X variable',names(X[1:8])),
           selectInput('ycol','Y Variable',names(X[1:8]),
                        selected=names(X)[[6]]),
         numericInput('clusters','Cluster amount',4,min = 1,max = 12)
        ),
               fluidRow(column( 3,
                  h3("Train"),
                 actionButton("Train","GO") #,
                 
                 #actionButton("refresh","start over")
                 )  ),  
        
                  tableOutput("tablle"),
                # h3("Coefficient table"),
                # textOutput("table1")),
        
                 column(3,
                        h3("Coefficient table"),
                      # textOutput("table1")),
                        tableOutput( "table1")),
                        
        mainPanel(
          
          plotOutput('plot1')
          
          )
) )

