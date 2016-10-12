#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "cpuid" @@ fun c ->
  Ok [ Pkg.mllib "src/cpuid.mllib";
       Pkg.clib "src/libcpuid_stubs.clib";
       Pkg.test "test/test"; ]
