# Development Data Products - Assignment
# Server file
#

#library(BiocManager)
#options(repos = BiocManager::repositories())
library(shiny)
library(ggplot2)
library(caret)
library(Hmisc)
library(rattle)
library(ISLR)
library(e1071)
#Wage<-readRDS(file = "data/my_wage.rds")
#Wage<-as.data.frame(read_csv("data/Data_wage.csv"))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    wageMod<-reactive({
        Wage2<-subset(Wage, wage>=input$sliderMin & wage<=input$sliderMax)
        cutwage<-cut2(Wage2$wage,g=as.numeric(input$groups))
        Wage2$Group<-as.character(paste(cutwage))
        Wage2
    })
    
    inTrainMod<-reactive({
        createDataPartition(y=wageMod()$Group, p=input$sliderPar, list=FALSE)
    })
    
    trainingMod<-reactive({
        wageMod()[inTrainMod(),]
    })
    
    testingMod<-reactive({
        wageMod()[-inTrainMod(),]
    })
    
    fitMod<-reactive({
        train(Group~.-logwage-wage, method="rpart", data=trainingMod())
    })
    
    output$distPlot <- renderPlot({
        
        fancyRpartPlot(fitMod()$finalModel)
        
    })
    
    output$accuracy <- renderText({
        confusionMatrix(table(
            testingMod()$Group, predict(fitMod(),testingMod())))$overall[1]
    })
    
    output$kappa <- renderText({
        confusionMatrix(table(
            testingMod()$Group, predict(fitMod(),testingMod())))$overall[2]
    })
    
    output$interval <- renderText({
        paste("(",round(confusionMatrix(table(
            testingMod()$Group, predict(fitMod(),testingMod())))$overall[3],4), ",",
            round(confusionMatrix(table(
                testingMod()$Group, predict(fitMod(),testingMod())))$overall[4],4),")",
            sep="")
    })
    
    output$table <- renderTable({
        results<-confusionMatrix(table("Reference" =
            testingMod()$Group, "Prediction" = predict(fitMod(),testingMod())))$table
    })
    
})
