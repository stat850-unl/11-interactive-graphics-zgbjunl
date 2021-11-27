library(shiny)
library(tidyverse)
library(shinydashboard)
cocktails <-
  readr::read_csv(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv'
  )
ui <- fluidPage(sidebarLayout(
  sidebarPanel(
    selectInput("Select1", "Ingredient", unique(cocktails$ingredient)),
    selectInput("Select2", "Drink", choices = NULL)
  ),
  mainPanel(tableOutput('ingredient_table'))
))

server <- function(input, output, session) {
  observeEvent(input$Select1, {
    updateSelectInput(session, 'Select2',
                      choices = unique(cocktails$name[cocktails$ingredient ==
                                                        input$Select1]))
  })

  output$ingredient_table <- renderTable({
    cocktails %>% filter(name == input$Select2) %>%
      select(ingredient, measure)
  })
}

shinyApp(ui = ui, server = server)

Sys.setlocale(locale="en_US.UTF-8")
rsconnect::setAccountInfo(name='nannanwang',
                          token='A58C4D800E8989D0F139D3632B056A85',
                          secret='nc5yofM7aYBHELqxSZbUzvspqHE/e3i2Vx5VDMtO')
