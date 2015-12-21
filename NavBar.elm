
module NavBar where
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import NavButton


-- MODEL

type alias Model = { buttons : List NavButton.Model } 

model : Model
model = { buttons = [] }

type alias ID = Int

initialize : List String -> Model
initialize names =
  let createButtons names =
    List.map (\button -> NavButton.initialize button) names
  in
    { model | buttons = createButtons names }


-- UPDATE 

type Action = Activate ID NavButton.Action

update : Action -> Model -> Model
update action model = 
  case action of
     Activate id buttonAction ->
      let updateButton buttonID buttonModel =
        if buttonID == id 
           then
             NavButton.update buttonAction buttonModel
           else
             buttonModel
      in
        { model | buttons = List.indexedMap updateButton model.buttons } 


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let 
      navButtons = List.indexedMap (viewButton address) model.buttons
  in
      ul [ navBarStyle ] navButtons


viewButton : Signal.Address Action -> ID -> NavButton.Model -> Html
viewButton address id model =
  NavButton.view (Signal.forwardTo address (Activate id)) model


navBarStyle : Attribute
navBarStyle =
  style 
    [ ("margin", "0px")
    , ("padding", "0px")
    ]
