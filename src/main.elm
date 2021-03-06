-- TODO: extract ports to a specific ports module


port module Main exposing (..)

import Html.App
import Html exposing (text, div)
import Task exposing (succeed)
import Http exposing (getString)
import Debug exposing (log)


--import Ports


main : Program Never
main =
    Html.App.program { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


view : Model -> Html.Html Msg
view model =
    List.map (\x -> text x.title) model.bookmarks
        |> div []


init : ( Model, Cmd Msg )
init =
    -- ( model, Cmd.none )
    ( default_model, requestInput )


default_model : Model
default_model =
    { text = ""
    , bookmarks = [ Bookmark "c" "c" "c" "c" [] ]
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
            ( { default_model | text = "Started!" }, Cmd.none )

        YamlToJson yaml ->
            ( model, yamlToJson yaml )

        YamlToJsonResponse bookmark_json ->
            -- ( { default_model | bookmarks = bookmark_json.bookmarks }, Cmd.none )
            ( { default_model | bookmarks = [ Bookmark (log "YamlToJsonResponse" "b") "b" "b" "b" [] ] }, Cmd.none )

        Error error_msg ->
            ( { default_model | error = Just error_msg }, Cmd.none )


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
