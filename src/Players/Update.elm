module Players.Update exposing (..)

import Navigation
import Players.Commands exposing (save)
import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        -- model
        FetchAllDone newPlayers ->
            ( newPlayers, Cmd.none )

        FetchAllFail error ->
            ( players, Cmd.none )

        SaveDone updatedPlayer ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        SaveFail error ->
            ( players, Cmd.none )

        -- commands
        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        ShowPlayers ->
            ( players, Navigation.modifyUrl "#players" )

        ShowPlayer id ->
            ( players, Navigation.modifyUrl ("#players/" ++ (toString id)) )


updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer
