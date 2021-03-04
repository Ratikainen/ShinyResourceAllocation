# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

#paramNames <- c("pop_size", "average_resource",
#                "var_total_resources", "fraction_to_reproduction",
#                "var_invest_repr")

simulate_RA <- function(params) {
  
  #-------------------------------------
  # Inputs
  #-------------------------------------
  
  # Initial 
  pop.size <- params$pop.size
  std.total.resources <- params$std.total.resources
  std.invest.reproduction <-params$std.invest.reproduction
  average.resource <- params$average.resource
  average.repr.allocation <- params$average.repr.allocation
  
  #-------------------------------------
  # Simulation
  #-------------------------------------
  
  # simulate 
  RA = matrix(0, pop.size, 4)
  
  RA[,1] <- rnorm(pop.size, mean = average.resource, sd = std.total.resources)
  RA[,2] <- rnorm(pop.size, mean = average.repr.allocation, sd = std.invest.reproduction)
  RA[,3] <- pmin((pmax((RA[,2]*RA[,1]), 0)),RA[,1])
  RA[,4] <- RA[,1]-RA[,3]
  
  return(RA)
}

shinyServer(function(input, output, session) {
  output$ResourceAllocation <- renderPlot({

    pop.size <-  input$pop_size
    std.total.resources <- sqrt(input$var_total_resources)
    std.invest.reproduction <- sqrt(input$var_invest_repr)
    average.resource <- input$average_resource
    average.repr.allocation <- input$fraction_to_reproduction
    

    ####
    #### Run model
    ####

      params <- list(pop.size = pop.size,
                     std.total.resources = std.total.resources,
                     std.invest.reproduction = std.invest.reproduction,
                     average.resource = average.resource,
                     average.repr.allocation = average.repr.allocation)
      
      RAout <- simulate_RA(params)
    
    ####
    #### Plot results
    ####
    #     matplot(seq(1,timeSim,1), Nsave, type="l")
    #plotD <- data.frame(Abundance = c(Nsave[,1], Nsave[,2]),
    #                    Species = c(rep("A",timeSim), rep("B", timeSim)),
    #                    Time = seq(1,timeSim,1))
    
    plot(RAout[,3],RAout[,4], las = 1, pch=16,xlab = 'R', ylab = 'S',
                    main = 'relationship between investment in reproduction and growth', ylim=c(0,10))
    
  })
})

