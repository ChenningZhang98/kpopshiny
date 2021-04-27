
server <- function(input, output, session) {
  
  # background image----
  output$image <- renderUI(
    if (input$arts != '') {
      setBackgroundImage(paste0(str_to_lower(input$arts),".png"))
    }
  )
  
  # small image----
  output$artImg <- renderUI(
    if (input$arts != '') {
      div(
        style = 'position:relative; overflow:hidden; 
                     border:0px solid #ffffff;
                     background-color:#4e4e4e;',
        img(
          src = paste0(
            gsub(' ','', str_to_lower(input$arts), fixed = T),'.png'
          ),
          width = '100%'
          
        )
      )
      
    }
  )
  
  # plays title----
  output$PlaysTitle <- renderText(
    if (input$arts != '') {
      paste0('<h4>Plays of ', input$arts,' Songs by Month</h4>' )
    }
  )
  
  # songs title----
  output$SongsTitle <- renderText(
    if (input$arts != '') {
      paste0('<h4>Songs of ', input$arts,'<h4>' )
    }
  )
  
  # reactive variables----
  a <- reactiveValues(sel = NULL, nS = 0, aR = 0, nP = 0)
  
  # render the summary metrics----
  output$nSongs <- renderText(paste0('<h4>', a$nS, '</h4>'))
  output$avgRat <- renderText(paste0('<h4>', a$aR, '</h4>'))
  output$nPlays <- renderText(paste0('<h4>', a$nP, '</h4>'))
  
  # chart of plays by month----
  output$playChrt <- renderPlot(
    {
      if (input$arts != '') {
        d <- dbGetQuery(
          conn = con, 
          statement = paste0('SELECT count(*)::numeric as plays, extract(month from dop)::int as months ',
                             'FROM plays WHERE artist = \'', input$arts, '\' ',
                             'GROUP BY 2 ORDER BY 2;')
        ) 
        print(d)
        ggplot(d,aes(x=months, y=plays)) + 
          geom_point(color = "red", size = 3) + 
          geom_smooth() + xlab("Month") +ylab("Plays") +
          theme(axis.text=element_text(size=22), axis.title=element_text(size=22, face = "bold")) +
          scale_x_continuous(breaks = seq(3, 12, by = 3)) + theme_minimal(base_size = 18)
      }
    }
  )
  
  # populate the reactive variable a when an artist is selected----
  observeEvent(
    eventExpr = input$arts,
    {
      session = session
      inputId = 'arts'
      # _data for the songs table----
      a$sel <- dbGetQuery(
        conn = con, 
        statement = paste0("select dor, song_name,case WHEN rating=1 THEN '*'WHEN rating=2 THEN '* *'WHEN rating=3 THEN '* * *'WHEN rating=4 THEN '* * * *'WHEN rating=5 THEN '* * * * *'end as ratings from songs where artist = \'", input$arts, "\' ")
      )
      # _data for number of songs metric----
      a$nS <- dbGetQuery(
        conn = con, 
        statement = paste0('select count(*)::numeric from songs where artist = \'', input$arts, '\' ')
      )
      # _data for average rating metric----
      a$aR <- dbGetQuery(
        conn = con, 
        statement = paste0('select round(avg(rating),2) from songs where artist = \'', input$arts, '\' ')
      )
      # _data for number of plays metric----
      a$nP <- dbGetQuery(
        conn = con, 
        statement = paste0('select count(*)::numeric from plays where artist = \'', input$arts, '\' ')
      )
    }
  )
  
  # table of songs by selected artist----
  output$songsA <- renderDataTable(
    if (input$arts != '') {
      data = a$sel
    }
  )
  
}

