module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type
    Msg
    -- model
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | SaveDone Player
    | SaveFail Http.Error
      -- commands
    | ChangeLevel PlayerId Int
    | ShowPlayers
    | ShowPlayer PlayerId
