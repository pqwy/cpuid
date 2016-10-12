(* Copyright (c) 2016 David Kaloper Meršinjak. All rights reserved.
   See LICENSE.md. *)

open Result
open Cpuid

let pp_list pp ppf = function
  | []    -> Format.pp_print_string ppf "[]"
  | [x]   -> Format.fprintf ppf "[%a]" pp x
  | x::xs -> Format.fprintf ppf "[@[%a%a@]]" pp x
              (fun _ -> List.iter (Format.fprintf ppf ";@ %a" pp)) xs

let (>>=) r k = match r with Ok x -> k x | Error e -> Error e

let () =
  match
    vendor () >>= fun v -> flags () >>= fun fs -> Ok (v, fs)
  with
  | Ok (v, fs) ->
      Format.printf "Vendor: %a@;Flags: %a\n%!"
      pp_vendor v (pp_list pp_flag) fs
  | Error e -> Format.printf "Error: %a\n%!" pp_error e
