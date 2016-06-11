-- TODO: extract ports to a specific ports module


port module Main exposing (..)

import Html.App
import Html exposing (text, div)
import Task exposing (succeed)
import Http exposing (getString)


--import Ports


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
    { text = ""
    , bookmarks = []
    , error = Nothing
    }


type alias Model =
    { text : String
    , bookmarks : List Bookmark
    , error : Maybe String
    }


type alias Bookmark =
    { date : String
    , link : String
    , title : String
    , summary : String
    , tags : List String
    }


type alias BookmarkJson =
    { bookmarks : List Bookmark }


type Msg
    = Start
    | YamlToJson String
    | YamlToJsonResponse (BookmarkJson)
    | Error String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            ( { model | text = "Started!" }, Cmd.none )

        YamlToJson yaml ->
            ( model, yamlToJson yaml )

        YamlToJsonResponse bookmarks_list ->
            ( model, Cmd.none )

        Error error_msg ->
            ( { model | error = Just error_msg }, Cmd.none )


requestInput : Cmd Msg
requestInput =
    Task.perform (\x -> Error (toString x))
        (\a -> YamlToJson a)
        (getString "/inputs/data.yml")



-- Subscriptions


port yamlToJson : String -> Cmd msg


port yamlToJsonResponse : (BookmarkJson -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    yamlToJsonResponse YamlToJsonResponse
