#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
#require "ocb-stubblr.topkg"
open Topkg

let opams = [Pkg.opam_file "opam" ~lint_deps_excluding:(Some ["ocb-stubblr"])]
let build = Pkg.build ~cmd:Ocb_stubblr_topkg.cmd ()
let () =
  Pkg.describe "cpuid" ~build ~opams @@ fun c ->
  Ok [ Pkg.mllib "src/cpuid.mllib";
       Pkg.clib "src/libcpuid_stubs.clib";
       Pkg.test "test/test"; ]
