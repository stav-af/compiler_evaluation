let rec fib n =
  if n < 2 then n
  else fib (n - 1) + fib (n - 2)

let () =
  let n = int_of_string Sys.argv.(1) in
  Printf.printf "%d\n" (fib n)