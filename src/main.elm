module Main exposing (..)

import Html.App
import Html exposing (text, div)


main : Program Never
main =
    Html.App.program { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


view : Model -> Html.Html Msg
view model =
    text "Hi bookmarks! 7"



-- div [] []


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


model : Model
model =
    { name = "zero" }


type alias Model =
    { name : String
    }


type Msg
    = StartOne
    | StartTwo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartOne ->
            ( { name = "one" }, Cmd.none )

        StartTwo ->
            ( { name = "two" }, Cmd.none )
