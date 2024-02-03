server <- function(input, output) {

  
  
  # render the scatterplot output ----
  output$penguin_scatterplot_output <- build-penguin-scatterplot(input)
  
  
  # render the histogram output ----
  output$penguin_histogram_output <- build-penguin-histogram(input)

  
} # END server