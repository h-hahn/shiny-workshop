# user interface -----
ui <- navbarPage(
  
  #theme = "shiny-fresh-theme.css",
  header = tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sass-styles.css")
  ),
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this page",
           
           
           # intro text fluidrow ----
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow ---- 
           
           hr(),
           
           includeMarkdown("text/footer.md")
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ---- 
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerinput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE
                          ),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select sampling section(s):",
                                               choices = c("clear cut forest", "old growth forest"),
                                               selected = c("clear cut forest", "old growth forest"),
                                               individual = FALSE, justified = TRUE, size = "sm",
                                               checkIcon = list(yes = icon("check"),
                                                                no = icon("xmark")))
                          
                        ), #END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            shinycssloaders::withSpinner(color = "cornflowerblue", type = 1)
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel
             
             # penguin tabPanel ----
             tabPanel(title = "Penguins",
                      
                      # penguin sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        sidebarPanel(
                          
                          # island pickerinput  ----
                          pickerInput(inputId = "penguin_island_input",
                                     label = "Select island(s):",
                                     choices = unique(penguins$island),
                                     selected = unique(penguins$island),
                                     options = pickerOptions(actionsBox = TRUE),
                                     multiple = TRUE), 
                          
                          # bin mumber sliderinput ----
                          sliderInput(inputId = "bin_num_input",
                                      label = "Select number of bins:",
                                      value = 25, min = 1, max = 100)
                          
                      ), # END penguin sidebarPanel
                      
                      
                      # penguin mainPanel ----
                      mainPanel(
                        
                        plotOutput(outputId = "flipper_length_histogram_output") %>% 
                          shinycssloaders::withSpinner(color = "palegreen3", type = 4, size = 2)
                        
                      ) # END penguin mainPanel
                      
             ) # END penguin sidebarLayout
           ) # END penguin tabPanel
           
  ) # END tabsetPanel
  
) # END (Page 2) data viz tabPanel

) # END navbarPage