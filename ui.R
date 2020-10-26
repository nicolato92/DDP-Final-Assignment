# Development Data Products - Assignment
# UI file
#

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Assignment - Decision Tree Algorithm"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons("groups", "Number of Wage Groups",
                         choices = list("Two Wage Groups"=2,
                                        "Three Wage Groups"=3,
                                        "Four Wage Groups"=4,
                                        "Five Wage Groups"=5),
                                        selected = 3),
            sliderInput("sliderMin",
                        "Min Wage",
                        min = 20.09,
                        max = 128.68,
                        value = 20.09),
            sliderInput("sliderMax",
                        "Max Wage",
                        min = 85.38,
                        max = 318.34,
                        value = 318.34),
            sliderInput("sliderPar","Data Partition Parameter:",
                        min = 0.4,
                        max = 0.9,
                        value = 0.7)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type="tabs",
                        tabPanel("Tree", br(), 
                                 h3("Decision Tree - Wage Data"),
                                 plotOutput("distPlot")),
                        tabPanel("Overall Statistics", br(), 
                                 h3("Overall Statistics"),
                                 h4("Accuracy", style="color:red"),
                                 textOutput("accuracy"),
                                 h4("Kappa", style="color:red"),
                                 textOutput("kappa"),
                                 h4("Confidence Interval", style="color:red"),
                                 textOutput("interval")),
                        tabPanel("Confusion Matrix", br(),
                                 h3("Confusion Matrix"),
                                 tableOutput("table")),
                        tabPanel("Instructions", br(),
                                 h3("Documentation"),
                                 p("This application runs a predictive algorithm
                                   using the 'Wage' dataset corresponding to the
                                   library 'ISLR'."),
                                 p("With respect to the data, it has the following
                                   11 variables: year, age, marital status, race,
                                   region, job class, health status, health insurance,
                                   logwage and wage."),
                                 p("The algorithm used for the application is decision
                                   trees, using the 'train' function and method 
                                   'rpart' (caret library). It is considered all
                                   the data with a data partition parameter equal
                                   to 0.7 by default. What the application seeks
                                   to estimate is the variable:'Wage Group', to which
                                   belongs a row of the data, this variable is
                                   calculated using the 'cutwage' function from
                                   the 'Hmsic' library."),
                                 strong("The user can change the range of the wage
                                        (min and max values), also it can be changed
                                        the data partition parameter between 0.4 and
                                        0.9 (training versus testing set) and the
                                        number of wage groups between two and five."),
                                 p("In the 'Tree' Tab, it shows the decision tree
                                   resulting from the estimate. In the 'Overall
                                   Statistics' Tab, it shows the accuracy, kappa and
                                   confidence interval obtained for the algorithm.
                                   And in the 'Confusion Matrix' Tab, it shows the
                                   corresponding matrix"),
                                 p("Notice that once it is changed some parameter,
                                   the algorithm will run automatically."),)
            )
        )
    )
))
