-- Chess timer for dummies
--
-- Dependencies:
--   elm install elm/time
--
-- First attempt at elm so not the perfect code

import Browser
import Html exposing (Html, div, button)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Task
import Time
import Time exposing (posixToMillis)
import String

-- CONSTANTS
max_seconds = 90
counter_start = 0
gs_play_not_started = 0
gs_game_started_p1 = 1
gs_game_started_p2 = 2

-- MAIN


main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { 
    timer1: Int,
    timer2: Int,
    p1: Int,
    p2: Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model counter_start counter_start gs_play_not_started gs_play_not_started
  , Cmd.batch
      [ 
        Task.perform Tick Time.now
      ]
  )



-- UPDATE

type Msg
  = Tick Time.Posix | TogglePlayer



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      if (model.p1 == gs_play_not_started) && 
      (model.p2 == gs_play_not_started) then
      ( model
      , Cmd.none
      )
      else
      ( { model | timer1 = model.timer1 + 1 }
      , Cmd.none
      )
    TogglePlayer -> 
       ({model | timer1=model.timer1+5}, Cmd.none) 

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Tick


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [button [] [ text (String.fromInt model.timer1 )],
     button [] [ text (String.fromInt model.timer2 )]
    ]

