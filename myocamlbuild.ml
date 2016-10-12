open Ocamlbuild_plugin

let param n v = [A n; A v]
let params n vs = List.(vs |> map (param n) |> flatten)

let clib libpath =
  let (dir, name) = Pathname.(dirname libpath, basename libpath) in
  let tag = "link_" ^ name in
  let libarg = "-l" ^ name in
  (* `dllib` is not supported by _tags. *)
  flag ["link"; "ocaml"; "library"; "byte"; tag] &
    S (param "-dllib" libarg);
  (* `cclib` is supported only for C. *)
  flag ["link"; "ocaml"; "library"; "native"; tag] &
    S (param "-cclib" libarg);
  (* `include` tag is not active during linking. OCB bug? *)
  flag ["link"; "ocaml"; "program"] & S (param "-I" dir);
  let libn = [dir^"/lib"^name^"."^ !Options.ext_lib] in
  dep ["link"; "ocaml"; tag] libn;
  dep ["compile"; "ocaml"; tag] libn

let () = dispatch @@ function
  | After_rules ->
      ocaml_lib "src/cpuid";
      clib "src/cpuid_stubs"
  | _ -> ()
