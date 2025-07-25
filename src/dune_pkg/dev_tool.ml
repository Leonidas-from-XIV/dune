open! Import

type t =
  | Ocamlformat
  | Odoc
  | Ocamllsp
  | Utop

let to_dyn = function
  | Ocamlformat -> Dyn.variant "Ocamlformat" []
  | Odoc -> Dyn.variant "Odoc" []
  | Ocamllsp -> Dyn.variant "Ocamllsp" []
  | Utop -> Dyn.variant "Utop" []
;;

let all = [ Ocamlformat; Odoc; Ocamllsp; Utop ]

let equal a b =
  match a, b with
  | Ocamlformat, Ocamlformat -> true
  | Odoc, Odoc -> true
  | Ocamllsp, Ocamllsp -> true
  | Utop, Utop -> true
  | (Ocamlformat | Odoc | Ocamllsp | Utop), _ -> false
;;

let package_name = function
  | Ocamlformat -> Package_name.of_string "ocamlformat"
  | Odoc -> Package_name.of_string "odoc"
  | Ocamllsp -> Package_name.of_string "ocaml-lsp-server"
  | Utop -> Package_name.of_string "utop"
;;

let of_package_name package_name =
  match Package_name.to_string package_name with
  | "ocamlformat" -> Ocamlformat
  | "odoc" -> Odoc
  | "ocaml-lsp-server" -> Ocamllsp
  | "utop" -> Utop
  | other -> User_error.raise [ Pp.textf "No such dev tool: %s" other ]
;;

let exe_name = function
  | Ocamlformat -> "ocamlformat"
  | Odoc -> "odoc"
  | Ocamllsp -> "ocamllsp"
  | Utop -> "utop"
;;

let exe_path_components_within_package t =
  match t with
  | Ocamlformat -> [ "bin"; exe_name t ]
  | Odoc -> [ "bin"; exe_name t ]
  | Ocamllsp -> [ "bin"; exe_name t ]
  | Utop -> [ "bin"; exe_name t ]
;;

let needs_to_build_with_same_compiler_as_project = function
  | Ocamlformat -> false
  | Odoc -> true
  | Ocamllsp -> true
  | Utop -> false
;;
