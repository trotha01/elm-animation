import Window
import Color exposing (white, blue, darkBlue)
import Graphics.Collage as Collage
import Graphics.Element exposing (Element)
import Time exposing (Time, second)
import Debug

import Animation exposing (..)

{-
 - Example Square animation
 -}

type Action = Tick Time
type alias Model = { s : Animation, clock : Time}
model0 = Model (animation 0 |> from 0 |> to big ) 0

small = 80
big = 160

actions : Signal Action
actions =
    Signal.map Tick (Time.fps 60)

step : Action -> Model -> Model
step act model =
    case act of
        Tick t -> {model| clock <- model.clock + t}

model : Signal Model
model = Signal.foldp step model0 actions

render : (Int, Int) -> Model -> Element
render (w, h) {s, clock} =
    let size = animate clock s
        rect = Collage.rect (size) (size) |> Collage.filled blue
     in Collage.collage 200 200 [ rect ]

main = Signal.map2 render Window.dimensions model

