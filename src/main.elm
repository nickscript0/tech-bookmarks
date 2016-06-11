-- TODO: extract ports to a specific ports module


port module Main exposing (..)

import Html.App
import Html exposing (text, div)
import Task exposing (succeed)
import Http exposing (getString)


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
    { text = "zero" }


type alias Model =
    { text : String
    }


type Msg
    = StartOne
    | JsYaml String
    | Error String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartOne ->
            ( { text = "one" }, Cmd.none )

        Error error_msg ->
            ( { text = error_msg }, Cmd.none )

        JsYaml yaml_str ->
            ( model, jsyaml yaml_str )



-- "greeting: hello\nname: world" )


requestInput : Cmd Msg
requestInput =
    Task.perform (\x -> Error "Error retrieving json")
        (\a -> JsYaml "greeting: hello\nname: world")
        (succeed Cmd.none)



-- Subscriptions


port jsyaml : String -> Cmd msg
