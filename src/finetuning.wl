(* ::Package:: *)

formatChatML[system_String, user_String, assistant_String] :=
    <|"messages" -> 
      {<|"role" -> "system", "content" -> system|>, 
       <|"role" -> "user", "content" -> user|>,
       <|"role" -> "assistant", "content" -> assistant|>} |>

formatChatML[system_String, {user_String, assistant_String}] :=
	formatChatML[system, user, assistant]

formatChatML[system_String, user_String->assistant_String] :=
	formatChatML[system, user, assistant]

formatChatML[user_String, assistant_String] :=
    <|"messages" -> 
    {<|"role" -> "user", "content" -> user|>, 
     <|"role" -> "assistant", "content" -> assistant|>}|>

exportChatML[filename_, lines_List] := With[
 {rows = ExportString[#, "JSON", "Compact" -> True]&/@ lines},
  Export[filename, #, "Text"]&@ StringRiffle[#, "\n"]&@ rows]
  
exportOpenPipeChatML[filename_, train_, test_]:= With[
	{tr = Append[<|"split"->"TRAIN"|>]/@ train,
	 te = Append[<|"split"->"TEST"|>]/@ test},
	exportChatML[filename, Join[tr, te]]]
	
importJSONL[filename_?FileExistsQ]:=
	ImportString[#, "RawJSON"]&/@ Import[filename, {"Text","Lines"}]
