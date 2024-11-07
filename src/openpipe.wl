(* ::Package:: *)

(* simple OpenAI-style HTTPRequest for a one-turn completion *)

(* 
Note that this looks up the OpenPipeAPIKey which can be stored persistent/secure
If you have not created this you'll need to make one by evaluating
SystemCredential["OpenPipeAPIKey"]= YOURSECRET KEY *)

OpenPipeRequest[messages_List, config_LLMConfiguration] :=
  HTTPRequest["https://app.openpipe.ai/api/v1/chat/completions",
  <|"Method"->"POST",
    "Headers"->{
      "Authorization"->"Bearer "<>SystemCredential["OpenPipeAPIKey"],
      "Content-Type"->"application/json",
      "op-log-request"->"true"},
    "Body"->ExportString[
      <|"model"-> config["Model"]["Name"],
        "messages"->messages,
        "temperature"->config["Temperature"]/.Automatic->1 (* set default T=1 *)
        |> ~Join~logProbs[config] (* append optional log-probs information*)
        , "JSON"]|>]

(* generation option log-probs configuration data *)
logProbs[_MissingQ] := <||>          
logProbs[n_Integer] := <|"logprobs"->True, "top_logprobs"->n|>
logProbs[config_LLMConfiguration] := logProbs@ Lookup["LogProbs"]@ First@ config

(* externally exposed function to create the request and read the result *)
OpenPipeExecute[messages_List, config_LLMConfiguration] := With[
   {response = URLRead@ OpenPipeRequest[messages, config]},
   If[response["StatusCode"] == 200,
     ImportString[#,"RawJSON"]&@ response["Body"], (*return response as data struct*)
     StringTemplate["Error: ``"]@response["StatusCode"] (*return error code as string*)
   ]]
