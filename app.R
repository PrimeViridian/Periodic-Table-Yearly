library(shiny)
library(dplyr)
library(readr)
library(ggplot2)

elements <- read_csv('elements.csv')

plot_table <- function(year_input) {
    plot_df <- elements %>% filter(year < year_input | is.na(year))
    ggplot(plot_df, aes(x=col, y=row, label=label, hue=era, fill=era)) +
        scale_y_reverse() +
        geom_tile() +
        geom_text()
}

ui <- fluidPage(
    plotOutput('periodic_table_plot'),
    sliderInput('year_slider', label='Year', min=1700, max=2010, value=1985),
    plotOutput('count_plot'),
    plotOutput('lag_plot')
)

server <- function(input, output) {
    output$periodic_table_plot <- renderPlot(plot_table(input$year_slider))
}

shinyApp(ui = ui, server = server)