library(shiny)
library(dplyr)

# file has columns: id, name, location, phone
od <- read.csv("OfficeDirectory.csv", stringsAsFactors = FALSE)
print(od)

ui <- fluidPage(
	titlePanel("Welcome to the Department of Biostatistics", windowTitle = "Office Directory"),
	fluidRow(
		column(3,h3("Need directions?"),uiOutput("nameOutput")),
		column(5,tableOutput("results"))
	),
	#hr(),
	plotOutput("pic1")

)


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

	#output$pic1 <- renderImage ({
	#	picfile <- "images/floorplan60a.jpg"
	#	list(src=picfile,
	#	alt="This is a picture")
	#}, 
	#deleteFile=FALSE)
	
#	output$pic1 <- 
#	  renderImage({
#	    filename <- normalizePath(file.path('./images',paste(input$nameInput, '.jpg', sep='')))
#		# Return a list containing the filename
#   		list(src = filename,alt="This is a picture")
#    }, deleteFile = FALSE)
#	reactive({
#	if (is.na(input$nameInput)) {
#	  filename <- "./images/floorplan60a.jpg"
#	  print(filename)
#	} else {
#	  filename <- normalizePath(file.path('./images',paste(input$nameInput, '.jpg', sep='')))
#	  print(filename)
#	}
#	})
	
	output$pic1 <- 
	  renderImage({
	    filename <- normalizePath(file.path('./images',paste(input$nameInput, '.jpg', sep='')))
	    # Return a list containing the filename
	    list(src = filename,alt="This is a picture")
	  }, deleteFile = FALSE)

}
    
shinyApp(ui = ui, server = server)


