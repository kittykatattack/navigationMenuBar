module ColorChanger where
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Graphics.Element exposing (..)
import NavBar
import ColorBox


-- MODEL

-- The model is a Record which contains two nested modules: `NavBar` and
-- `ColorBox`. The `ColorBox` is a simple square <div> with a function
-- called `changeColor` that lets you set its color. The `NavBar` is a
-- <ul> with dynamic list of <li> elements as buttons. Each button in
-- the `NavBar` is a nested `NavButton` module

type alias Model =
  { navigationBar : NavBar.Model
  , colorBox : ColorBox.Model
  }

-- Initialize the `navigationBar` with a List of button names. Each
-- button name happens to also be a CSS color string. Those same string
-- names will be used to set the color of the color box when any of
-- the buttons in the navigation bar are clicked

model : Model
model = 
  { navigationBar = NavBar.initialize ["Blue", "Pink", "Orange"]
  , colorBox = ColorBox.model
  }

-- UPDATE

type Action = UpdateNavigation NavBar.Action 

update : Action -> Model -> Model
update action model =
  case action of
    UpdateNavigation action ->
      let
        
        -- Get a new updated version of the navigation bar

        newNavBar = NavBar.update action model.navigationBar

        -- Get the color of the NavBar's selected button

        getColor selectedButton =
          if selectedButton /= "" 
             then 
               ColorBox.changeColor selectedButton
             else 
               model.colorBox

      in

      -- Update the model with the new navigation bar and set the
      -- `colorBox` to the color of the new navigation bar's
      -- `selectedButton 

      { model
          | navigationBar = newNavBar
          , colorBox = getColor newNavBar.selectedButton
      }

-- VIEW

-- Forward the navigation bar's actions to `UpdateNavigation` and
-- display the current `colorBox` model

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ NavBar.view (Signal.forwardTo address UpdateNavigation) model.navigationBar
    , ColorBox.view model.colorBox
    ]
