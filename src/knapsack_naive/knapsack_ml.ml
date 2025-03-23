let rec generate_list start n =
  if n <= 0 then []
  else start :: (generate_list (start +. 1.0) (n - 1))

let rec knapSack weights values capacity =
  match weights, values with
  | [], _ -> 0.0
  | _, [] -> 0.0
  | whead :: wtail, vhead :: vtail ->
      if capacity < 0.0 then
        0.0
      else if whead > capacity then
        knapSack wtail vtail capacity
      else
        let excludeVal = knapSack wtail vtail capacity in
        let includeVal = vhead +. knapSack wtail vtail (capacity -. whead) in
        if excludeVal > includeVal then excludeVal else includeVal

let () =
  let n = int_of_string Sys.argv.(1) in
  let big_weights = generate_list 1.0 n in
  let big_values  = generate_list 10.0 n in
  let ans = knapSack big_weights big_values 400.0 in
  Printf.printf "%f\n" ans