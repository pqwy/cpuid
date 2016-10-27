open Ocamlbuild_plugin

(* let () = dispatch Ocb_stubblr.init *)

(* <= 4.02.X *)
let () = dispatch Ocb_stubblr.(init & ccopt_flags "--std=c99 -Wall -Wextra -O3")
