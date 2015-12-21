
import NavBar exposing (initialize, update, view)
import StartApp.Simple exposing (start)

main = 
  start
    { model = 
        initialize 
          [ "Here are"
          , "some"
          , "navigation"
          , "bar elements" 
          , "...and one more"
          ]
    , update = update
    , view = view
    }
