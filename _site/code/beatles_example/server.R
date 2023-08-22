#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(babynames)
library(shiny)

# Set-up a table globally that is NOT reactive to input containing all of the
# baby names:
Beatles <- babynames %>%
    filter(name %in% c("John", "Paul", "George", "Ringo") & sex == "M")

shinyServer(
    function(input, output) {
        # Create the plot based on the input
        output$plot <- renderPlot({
            Beatles %>%
                filter(year >= input$startyear, 
                       year <= input$endyear,
                       name %in% input$names) %>%
                ggplot(aes(x = year, y = prop, color = name,
                           group = name)) +
                geom_line(size = 2) +
                theme_bw() +
                ggthemes::scale_color_colorblind() +
                theme(legend.position = "bottom")
        })
    }
)