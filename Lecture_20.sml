signature GAME =
sig
  datatype player = Minnie | Maxie
  datatype outcome = Winner of player | Draw
  datatype status = Over of outcome | In_play
  type state (* Game States, dependent on specific game *)
  type move  (* How do game states change and update *)

  datatype (* Estimator *) est = Definitely of outcome
                               | Guess of int (* How strong is the guess *)
  (* REQ : state instance should be In_play *)
  val estimator : state -> est
  val start : state

  (* REQ : move instance is a valid move *)
  val make_move : state * move -> state

  (* REQ : state instance is In_play
   * ENS : returns a non-empty Seq *)
  val moves : state -> move Seq.seq (* a sequence of all possible moves *)

  (* View : to see the key parts of an abstracted structure *)
  val status : state -> status
  val player : state -> player
end

structure Game :> GAME =
struct
