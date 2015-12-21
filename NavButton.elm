module NavButton where
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Graphics.Element exposing (..)


-- MODEL

type alias Model =
  { content : String
  , textColor : String
  , backgroundColor : String
  }

model = 
  { content = "Test"
  , textColor = "white"
  , backgroundColor = "darkGrey"
  }


initialize : String -> Model
initialize content = 
  { model | content = content }


-- UPDATE

type Action = On | Off

update : Action -> Model -> Model
update action model = 
  case action of
    On -> 
      { model | textColor = "red" }

    Off ->
      { model | textColor = "white" }


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  li [ navButtonStyle model
    , onMouseEnter address On
    , onMouseLeave address Off 
    ] 
    [ text model.content ]


navButtonStyle : Model -> Attribute
navButtonStyle model =
  style 
    [ ("color", model.textColor) 
    , ("background", model.backgroundColor)
    , ("height", "50px")
    , ("width", "150px")
    , ("display", "flex")
    , ("justify-content", "center")
    , ("align-items", "center")
    , ("cursor", "pointer")
    , ("margin-bottom", "10px")
    , ("-webkit-user-select", "none")
    , ("-moz-user-select", "none")
    , ("-khtml-user-select", "none")
    , ("-ms-user-select", "none")
    , ("userSelect", "none")
    ]
