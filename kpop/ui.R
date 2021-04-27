ui <- tagList(
  uiOutput('image'),
  fluidPage(
    theme = shinytheme('lumen'),
    br(),
    tabsetPanel(
      type = 'pills',
      tabPanel(
        title = h3('K-Pop Dashboard'),
        br(),
        fluidRow(
          align = 'center',
          column(
            width = 6,
            wellPanel(
              fluidRow(
                column(
                  width = 4,
                  # drop down list to select an artist----
                  pickerInput(
                    inputId = 'arts',
                    label = 'Artist',
                    choices = artsts,
                    options = list(
                      title = 'Select an Artist'
                    )
                  )
                ),
                column(
                  width = 8,
                  align = 'center',
                  # small image of artist----
                  uiOutput('artImg')
                )
              ),
              hr(),
              # chart of plays of songs by artist----
              htmlOutput('PlaysTitle'),
              plotOutput(
                outputId = 'playChrt'
              )
            )
          ),
          column(
            width = 6,
            # metrics for artist----
            fluidRow(
              column(
                width = 4,
                # _number of songs by artist in the kpop db----
                wellPanel(
                  style = 'background-color: #cce8c9;',
                  h4('# of Songs'),
                  hr(),
                  htmlOutput(
                    outputId = 'nSongs'
                  )
                )
              ),
              column(
                width = 4,
                # _average rating of songs by artist in the kpop db----
                wellPanel(
                  style = 'background-color: #c2d8e5;',
                  h4('Avg Rating'),
                  hr(),
                  htmlOutput(
                    outputId = 'avgRat'
                  )
                )
              ),
              column(
                width = 4,
                # _number of plays of songs by artist in the kpop db----
                wellPanel(
                  style = 'background-color: #c9bdd5;',
                  h4('# of Plays'),
                  hr(),
                  htmlOutput(
                    outputId = 'nPlays'
                  )
                )
              )
            ),
            # table of songs by artist in the kpop db----
            wellPanel(
              htmlOutput('SongsTitle'),
              dataTableOutput(
                outputId = 'songsA'
              )
            )
          )
        )
      ),
      tabPanel(
        # tab to see big image of artist----
        title = h3('Image')
      )
    )
  )
)
