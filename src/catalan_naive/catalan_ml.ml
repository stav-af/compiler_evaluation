let rec catalan n =
  if n = 0 then 1
  else catalan_sum n 0

and catalan_sum n i =
  if i = n then 0
  else catalan i * catalan (n - 1 - i) + catalan_sum n (i + 1)

let () =
  let n = int_of_string Sys.argv.(1) in
  Printf.printf "%d\n" (catalan n)