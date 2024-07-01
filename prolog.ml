open Lexer;;
open Parser;;
open Interpreter;;

let fstream = open_in Sys.argv.(1);;
let init_prog = Parser.program Lexer.read (Lexing.from_channel fstream);;
let _ = checkProgram init_prog;;
let prog = modifyInitialProg init_prog 1;;

try
  while(true) do
    print_string "?- ";
    let line = read_line() in
    if line = "halt." then exit 0
    else try
      let g = Parser.goal Lexer.read (Lexing.from_string line) in
      match (interpret_goal prog g) with
          (true, _) -> print_string "true.\n"
        | (false, _) -> print_string "false.\n"
    with e -> Printf.printf "%s\n" (Printexc.to_string e)
  done

with _ -> print_string "\n% halt\n"
