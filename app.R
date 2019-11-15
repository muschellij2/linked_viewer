#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(neurobase)
library(papayaWidget)
library(shiny)
# 
# <div style="width: 100%; overflow: hidden;">
#     <div style="width: 25%; float: left;"> 
#         ```{r}
#     papaya(list(img, imgs$`4`), sync_view = TRUE, hide_toolbar = FALSE, hide_controls = TRUE, orthogonal = FALSE)
#     ```
#     </div>
#         
#         <div style="width: 55%; float: right;"> 
#         ```{r}    
#     papaya(list(img, imgs$`5`), sync_view = TRUE, hide_toolbar = FALSE, hide_controls = TRUE, orthogonal = FALSE)
#     ```
#     </div>
#         </div>
#         

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    title = "Side-by-Side Viewer",
    
    fileInput('i1', multiple = TRUE, 
              label = "First Panel Images"),
    fileInput('i2', multiple = TRUE, 
              label = "First Panel Images"),    
    
    hr(),
    
    fluidRow(
        column(6,
               papayaOutput('image1', height = "600px")
        ),
        column(6,
               papayaOutput('image2', height = "600px")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$image1 <- renderPapaya({
        validate(
            need(input$i1, 'Check at least one image!')
        )
        papaya(img = input$i1$datapath, sync_view = TRUE, 
               hide_toolbar = FALSE, hide_controls = TRUE, 
               orthogonal = TRUE)
    })
    output$image2 <- renderPapaya({
        validate(
            need(input$i2, 'Check at least one image!')
        )
        papaya(img = input$i2$datapath, sync_view = TRUE, 
               hide_toolbar = FALSE, hide_controls = TRUE, 
               orthogonal = TRUE)
        
    })    
}

# Run the application 
shinyApp(ui = ui, server = server)
