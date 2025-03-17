let fib n =
  let rec fib_helper n a b =
    if n = 0 then a
    else if n = 1 then b
    else fib_helper (n - 1) b (a + b)
  in fib_helper n 0 1

let () =
  let n = int_of_string Sys.argv.(1) in
  Printf.printf "%d\n" (fib n)