#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
#require "ocb-stubblr.topkg"
open Topkg

let build = Pkg.build ~cmd:Ocb_stubblr_topkg.cmd ()
let () =
  Pkg.describe ~build "cpuid" @@ fun c ->
  Ok [ Pkg.mllib "src/cpuid.mllib";
       Pkg.clib "src/libcpuid_stubs.clib";
       Pkg.test "test/test"; ]
