# dashboard header -------------------------------------
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
  
)

# dashboard sidebar -------------------------------------
sidebar <- dashboardSidebar(
  
  # sidebar ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
  ) # END sidebarMenu
  
)

# dashboard body -------------------------------------
body <- dashboardBody(
  
  # set theme ----
  fresh::use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "welcome",
            
            # left-hand column
            column(width = 6, 
                   
                   # background info box ----
                   box(width = NULL,
                       
                       title = tagList(icon("water"),
                                       strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                                alt = "A map of Northern Alaska, showing Fish Creek Watershed located within the National Petroleum Reserve.",
                                style = "max-width: 100%;"),
                       tags$h6(tags$em("Map source:", tags$a(href = "http://fishcreekwatershed.org/",
                                                             "FCWO")),
                               style = "text-align: center;")
                       
                   ) # END background box
                   
            ), # END column
            
            # right-hand column
            column( width = 6,
                    
                    # first fluid row ----
                    fluidRow(
                      
                      # citation box ----
                      box(width = NULL,
                          
                          title = tagList(icon("table"),
                                          strong("Data Source")),
                          includeMarkdown("text/citation.md")
                          
                      ) # END citation box
                      
                    ), # END first fluidRow
                    
                    # second fluidRow ----
                    fluidRow(
                      
                      
                      # disclaimer box ----
                      box(width = NULL,
                          
                          title = tagList(icon("thumbs-down"),
                                          strong("Disclaimer")),
                          includeMarkdown("text/disclaimer.md")
                          
                      )# END disclaimer box
                      
                    ) # END second fluidRow
                    
            ) # END right-hand column
            
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4, 
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # sliderInput elevation ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (m.a.s.l):",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))
                  ), 
                  
                  # sliderInput temp ----
                  sliderInput(inputId = "temp_slider_input",
                              label = "Temperature (ºC)",
                              min = round(min(lake_data$AvgTemp), 2),
                              max = round(max(lake_data$AvgTemp), 2),
                              value = c(round(min(lake_data$AvgTemp), 2),
                                        round(max(lake_data$AvgTemp), 2))
                  ),
                  
                  # sliderInput depth ----
                  sliderInput(inputId = "depth_slider_input",
                              label = "Depth (m)",
                              min = round(min(lake_data$AvgDepth), 2),
                              max = round(max(lake_data$AvgDepth), 2),
                              value = c(round(min(lake_data$AvgDepth), 2),
                                        round(max(lake_data$AvgDepth), 2))
                  )
                  
              ), # END input box
              
              # map box ----
              box(width = 8, 
                  
                  title = strong("Monitoring lakes within Fish Creek Watershed:"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1)
                  
              ) # END map box
              
            ) # END fluidRow
            
    ) # END dashboard tabItem
    
  ) # END tabItems
  
)

# combine all into a dashboard page ---------
dashboardPage(header, sidebar, body)

