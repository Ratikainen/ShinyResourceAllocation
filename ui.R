# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)


shinyUI(navbarPage("Tutorial",
                   tabPanel("Resource allocation: simulating allocation to reproduction and growth/survival",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("pop_size", "Number of individuals in population:", min = 10, max = 200, value = 50),
                                sliderInput("fraction_to_reproduction", "Fraction of resources to reproduction(R):", min = 0.0, max = 0.9, value = 0.5),
                                sliderInput("var_invest_repr", "Variance in fraction of resources to reproduction(R):", min = 0, max = .1, value = 0.05),
                                sliderInput("average_resource", "Average resources available to an individual:", min = 1, max = 10, value = 5),
                                sliderInput("var_total_resources", "Variance in resources available to an individual:", min = 0.0, max = 10.0, value = 1)),
                              # Show a plot of the generated distribution
                              mainPanel(
                                helpText("Based on the model in van Noordwijk and de Jong (1986) Am. Nat."),
                                helpText("All parameters in the model can be adjusted in the panel on the left. Try to figure out what happens when you adjust the different parameters"),
                                plotOutput("ResourceAllocation"),
                                helpText("How do you think the variance in fraction of investment to reproduction will be after many years of evolution in one environment? What will happen if the environment changes?")
                            )))))