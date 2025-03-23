let catalan n =
  let memo = Array.make (n + 1) (-1L) in
  let rec cat n =
    if memo.(n) <> (-1L) then memo.(n)
    else
      let res = ref 0L in
      for i = 0 to n - 1 do
        res := Int64.add !res (Int64.mul (cat i) (cat (n - 1 - i)))
      done;
      memo.(n) <- !res;
      !res
  in
  memo.(0) <- 1L;
  cat n

let () =
  let n = int_of_string Sys.argv.(1) in
  Printf.printf "%Ld\n" (catalan n)