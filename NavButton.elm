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
  , selected : Bool
  }

model : Model
model = 
  { content = "Test"
  , textColor = "white"
  , backgroundColor = "darkGrey"
  , selected = False
  }


initialize : String -> Model
initialize content = 
  { model | content = content }


-- UPDATE

-- `Over` and `Out` are the button's hover states. `Select` and
-- `Deselect` determine its selection state

type Action 
  = Over 
  | Out
  | Select
  | Deselect

update : Action -> Model -> Model
update action model = 
  case action of
    Over -> 
      { model | textColor = "red" }

    Out ->
      { model | textColor = "white" }

    Select ->
      { model
          | backgroundColor = "grey" 
          , selected = True
      }

    Deselect ->
      { model
          | backgroundColor = "darkGrey" 
          , selected = False
      }


-- VIEW

-- Create a Context so that the `select` action can be
-- handled by the parent module. `actions` refer to the
-- `Over` and `Out` actions that are handled locally.
-- `select` is an action that is going to be handled 
-- by the parent `MavBar` module

type alias Context = 
  { actions : Signal.Address Action
  , select : Signal.Address ()
  }


-- The view sends the addressed action through
-- the context so that it can be redirected, if need be.
-- `oncClick` triggers the `select` action, which will
-- be handled by the parent `NavBar` module

view : Context -> Model -> Html
view context model =
  li 
    [ navButtonStyle model
    , onMouseEnter context.actions Over
    , onMouseLeave context.actions Out
    , onClick context.select ()
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
