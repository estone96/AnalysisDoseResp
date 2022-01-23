## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    skin = 'yellow',
    dashboardHeader(title = "Dose Study Analysis"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Settings", tabName = "summary")
        ),
        downloadButton("out_package","Get Report"),
        tags$style(type='text/css', "#out_report { width:90%; margin-left: 30px; color: black;}")
    ),
    dashboardBody(
        tabItems(
            tabItem("summary",
                    fluidRow(
                        box(
                            width = 8, status = "info", solidHeader = TRUE,
                            title = "Study Title",
                            textInput("studyname","Input name for the study"),
                            textInput("Outcome1","Input name for outcome1"),
                            textInput("Outcome2","Input name for outcome2"),
                            textInput("Outcome3","Input name for outcome3"),
                            textInput("Outcome4","Input name for outcome4")
                            
                        ),
                        box(
                            width = 8, status = "info",
                            title = "About",
                            p("Package generator for generic dose study")
                        )
                    )
            )
        )
    )
)

server <- function(input, output) {
    studyname <- reactive({
        input$studyname
    })  
    data_params = reactive({
        params_input = list()
        params_input[['studyname']] = input$studyname
        params_input[['Outcome1']] = input$Outcome1
        params_input[['Outcome2']] = input$Outcome2
        params_input[['Outcome3']] = input$Outcome3
        params_input[['Outcome4']] = input$Outcome4
        return(params_input)
    })
    
    
    output$out_package = downloadHandler(
        filename = function(){
            paste(studyname(),'.zip',sep='')
        },
        content = function(file){
            paramslist = data_params()
            rmarkdown::render(input = 'AnalysisDoseResp.Rmd',
                              output_file = paste(tempdir(),"/",'analysisdoseresp.html',sep=''),
                              params = list(outcome_1_name = paramslist$outcome1,
                                            outcome_2_name = paramslist$outcome2,
                                            outcome_3_name = paramslist$outcome3,
                                            outcome_4_name = paramslist$outcome4))
            #go to a temp dir to avoid permission issues
            owd <- setwd(tempdir())
            on.exit(setwd(owd))
            files = c('analysisdoseresp.html')
            #create the zip file
            system2("zip", args=(paste(file,files,sep=" ")))
        },
        contentType = "application/zip"
    )
}

shinyApp(ui, server)