
module NavBar where
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import NavButton 


-- MODEL

-- The navgation bar's model contains a list of `NavButton` models
-- called `buttons` and a `selectedButton` string, which holds the
-- name of the currently clicked button

type alias Model = 
  { buttons : List NavButton.Model 
  , selectedButton : String
  } 

model : Model
model = 
  { buttons = [] 
  , selectedButton = ""
  }

type alias ID = Int


-- The buttons are initialized with a List of button names

initialize : List String -> Model
initialize names =
  let createButtons names =
    List.map (\button -> NavButton.initialize button) names
  in
    { model | buttons = createButtons names }


-- UPDATE 

-- The navigation bar has two actions: `Hover`, which is the
-- mouse-over effect, and `Select` which sets the currently selected
-- button

type Action 
  = Hover ID NavButton.Action
  | Select NavButton.Model

update : Action -> Model -> Model
update action model = 
  case action of
     Hover id buttonAction ->
      let 

        -- `updateButton` checks whether the current button
        -- being looped through matches the currently active button
        -- ID. If it does, the corresponding nested NavButton.Model is
        -- updated

        updateButton buttonID buttonModel =
          if buttonID == id 
             then
               NavButton.update buttonAction buttonModel
             else
               buttonModel
      in

        -- Return a new model in which the currently active button
        -- has its Hover on and off states updated

        { model 
            | buttons = List.indexedMap updateButton model.buttons
        } 

     Select selectedButtonModel ->

        let

          -- `updateButton` checks whether a button has the same
          -- content string as the selected button. If it does, it
          -- updates the model and sets its action to `Select`.
          -- If it doesn't, it sets the button's action to `Deselect`
          -- (See the `NavButton` module for details on how this works.)

          updateButton buttonModel =
            if buttonModel.content == selectedButtonModel.content
               then
                 NavButton.update NavButton.Select buttonModel
               else
                 NavButton.update NavButton.Deselect buttonModel

        in

        -- Set the name of the currently clicked-on button as the
        -- model's `selectedButton` and update the buttons to reflect
        -- their selection state

        { model 
            | selectedButton = selectedButtonModel.content
            , buttons = List.map updateButton model.buttons
        }

-- VIEW

-- Display a list of navigation buttons using nested `NavButton`
-- module

view : Signal.Address Action -> Model -> Html
view address model =
  let 
      navButtons = List.indexedMap (viewButton address) model.buttons
  in
      ul [ navBarStyle ] navButtons

-- Use the NavButton's Context to choose the correct action. The
-- reason we need to use a Context is so that this `NavBar` module can
-- handle the nested `NavButton`'s `select` `onClick` action. We want
-- `select` to change the `selectedButton` value in **this module**,
-- so we have to handle it here. Using the `NavButton`'s Context let's
-- us do this: it lets us wire the `select` action from the nested
-- child module to this parent. See the `NavButton` module for details on how the
-- context was created. See example #4 in the Elm Architecture for
-- details on how to create and use a Context.

viewButton : Signal.Address Action -> ID -> NavButton.Model -> Html
viewButton address id model =
  let context =
      NavButton.Context
        (Signal.forwardTo address (Hover id))
        (Signal.forwardTo address (always (Select model)))
  in
    NavButton.view context model


navBarStyle : Attribute
navBarStyle =
  style 
    [ ("margin", "0px")
    , ("padding", "0px")
    ]
