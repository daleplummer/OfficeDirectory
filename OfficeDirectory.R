library(shiny)
library(dplyr)

# file has columns: id, name, location, phone
od <- read.csv("OfficeDirectory2525.csv", stringsAsFactors = FALSE)
print(od)
#
# ui
#
ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel("Welcome to the Department of Biostatistics", windowTitle = "Office Directory"),
	fluidRow(
	  column(width=3,h4(uiOutput("nameOutput"))),
	  column(width=6,h4(tableOutput("results"))),
	  column(width=1,actionButton("reset", "Reset"))
	),
	plotOutput("pic1")
)
#
# server
#
server <- function(input, output) {

	output$nameOutput <- renderUI({
		selectInput("nameInput", "Select a name:", sort(unique(od$name)))
	})

	filtered <- reactive({
		if (is.null(input$nameInput)) {
			return(NULL)
		}
		od %>%
		filter(name == input$nameInput)
	})

	output$results <- renderTable({
		filtered()
	})

	output$pic1 <- 
	  renderImage({
	    filename <- normalizePath(file.path('./images',paste(input$nameInput, '.jpg', sep='')))
	    # Return a list containing the filename
	    list(src = filename,alt="This is a picture")
	  }, deleteFile = FALSE)
	
	observeEvent(input$reset, {
	  shinyjs::reset("nameOutput")
	})
	
}
    
shinyApp(ui = ui, server = server)


