let knapSackDP weights values capacity =
  let n = List.length weights in
  let cap = int_of_float capacity in
  let dp = Array.make_matrix (n+1) (cap+1) 0.0 in

  let rec fill_i i ws vs =
    match ws, vs with
    | [], _ -> ()
    | whead :: wtail, vhead :: vtail ->
        let w = int_of_float whead in
        for c = 0 to cap do
          if w > c then
            dp.(i).(c) <- dp.(i-1).(c)
          else
            let excludeVal = dp.(i-1).(c) in
            let includeVal = vhead +. dp.(i-1).(c - w) in
            dp.(i).(c) <- if excludeVal > includeVal then excludeVal else includeVal
        done;
        fill_i (i+1) wtail vtail
  in

  fill_i 1 weights values;
  dp.(n).(cap)

let () =
  let n = int_of_string Sys.argv.(1) in
  let rec range_d start finish =
    if start > finish then [] else (float_of_int start) :: (range_d (start+1) finish)
  in
  let big_weights = range_d 1 n in
  let big_values  = range_d 10 (9 + n) in

  let ans = knapSackDP big_weights big_values 400.0 in
  Printf.printf "%f\n" ans