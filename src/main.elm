-- TODO: extract ports to a specific ports module


module Main exposing (..)

import Html.App
import Html exposing (text, div)
import Task exposing (succeed)
import Http exposing (getString)
import Ports


main : Program Never
main =
    Html.App.program { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


view : Model -> Html.Html Msg
view model =
    text "Hi bookmarks! 7"


init : ( Model, Cmd Msg )
init =
    -- ( model, Cmd.none )
    ( model, requestInput )


model : Model
model =
    { text = "zero", error = Nothing }


type alias Model =
    { text : String
    , error : Maybe String
    }


type Msg
    = StartOne
    | JsYaml String
    | Error String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartOne ->
            ( { model | text = "one" }, Cmd.none )

        Error error_msg ->
            ( { model | error = Just error_msg }, Cmd.none )

        JsYaml yaml_str ->
            ( model, Ports.jsyaml yaml_str )


requestInput : Cmd Msg
requestInput =
    Task.perform (\x -> Error (toString x))
        (\a -> JsYaml a)
        (getString "/inputs/data.yml")



-- Subscriptions
