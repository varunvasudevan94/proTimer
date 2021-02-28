-- Chess timer for dummies
--
-- Dependencies:
--   elm install elm/time
--
-- First attempt at elm so not the perfect code

module Main exposing (..)

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Task
import Time
import Time exposing (posixToMillis)
import Html.Styled.Events exposing (onClick)
import Html.Styled exposing (button, text)
import Html.Styled.Attributes exposing (css, href, src)
import String

-- CONSTANTS


max_seconds = 180
counter_start = 0
gs_play_not_started = 0
gs_game_started_p1 = 1
gs_game_started_p2 = 2


theme : { black : Color, white : Color }
theme =
    { black = hex "F9F4F3"
    , white = hex "3B3230"
    }


-- MAIN


main =
  Browser.element
    { init = init
    , view = view >> toUnstyled
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL


type alias Model =
  { 
    timer1: Int,
    timer2: Int,
    player: Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model counter_start counter_start gs_play_not_started
  , Cmd.batch
      [ 
        Task.perform Tick Time.now
      ]
  )

-- HELPER METHODS


getSecondsLeft : Int -> Int
getSecondsLeft second = max_seconds - second

getSeconds : Int -> Int
getSeconds counter = remainderBy 60 counter

getMinutes : Int -> Int
getMinutes counter = counter // 60 -- Buddy this is integer division

formatInteger : Int -> String
formatInteger integer = 
  if integer < 10 then 
    "0" ++ String.fromInt(integer)
  else
    String.fromInt(integer)
    

formatSecondsToDisplay : Int -> String
formatSecondsToDisplay counter = 
  (formatInteger (getMinutes counter)) ++ ":" ++ (formatInteger (getSeconds counter))

-- UPDATE


type Msg
  = Tick Time.Posix | TogglePlayer1 | TogglePlayer2



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      if (model.timer1 == max_seconds || model.timer2 == max_seconds) then
        ( model
        , Cmd.none
        )
      else
        if model.player == gs_play_not_started then
          ( model
          , Cmd.none
          )
        else
          if model.player == gs_game_started_p1 then
            ( { model | timer1 = model.timer1 + 1 }
            , Cmd.none
            )
          else
            ( { model | timer2 = model.timer2 + 1 }
            , Cmd.none
            ) 
        
    TogglePlayer1 -> 
        if model.player == gs_play_not_started then
          ({model | player=gs_game_started_p1}, Cmd.none) 
        else
          ({model | player=gs_game_started_p2}, Cmd.none)
    TogglePlayer2 -> 
        if model.player == gs_play_not_started then
          (model, Cmd.none) 
        else
          ({model | player=gs_game_started_p1}, Cmd.none)

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Tick


-- VIEW


view : Model -> Html Msg
view model =
  div [css [height (vh 100)]]
    [button [onClick TogglePlayer1, css [width (pct 100), height (pct 50), color theme.white, backgroundColor theme.black]] [ text (formatSecondsToDisplay (getSecondsLeft model.timer1 ))],
     button [onClick TogglePlayer2, css [width (pct 100), height (pct 50), color theme.black, backgroundColor theme.white]] [ text (formatSecondsToDisplay (getSecondsLeft model.timer2 ))]
    ]

