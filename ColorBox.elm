module ColorBox where
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Graphics.Element exposing (..)


-- MODEL

type alias Model =
  { color : String
  , width : Int
  , height : Int
  }

model : Model
model = 
  { color = "red"
  , width = 200
  , height = 200
  }


-- UPDATE

changeColor : String -> Model
changeColor newColor =
  { model | color = newColor }


-- VIEW

view : Model -> Html
view model =
  div [ boxStyle model ] []


boxStyle : Model -> Attribute
boxStyle model =
  style 
    [ ("background", model.color)
    , ("width", toString model.width ++ "px")  
    , ("height", toString model.height ++ "px")  
    , ("display", "block")  
    ]
