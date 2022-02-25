let () =
  let ch = open_out "foo.ml" in
  output_string ch "let () = print_endline \"Everything ok\"\n";
  close_out ch
