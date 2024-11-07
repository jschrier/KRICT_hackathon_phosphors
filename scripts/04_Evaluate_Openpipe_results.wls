#!/usr/bin/env wolframscript
(* ::Package:: *)

(* openpipe automatically evaluates the test set; download the report and process *)

SetDirectory@ NotebookDirectory[];
<<"../src/finetuning.wl"
results = importJSONL["../results/KRICT_Phosphors_(test_entries).jsonl"];


outputs = AssociationThread[
  results[[1, "outputs", All,"model"]],
  Transpose@results[[All, "outputs", All, "message", "content"]]];


ClassifierMeasurements[
 outputs["openpipe:phosphors-llama31-8b"],
 outputs["Dataset Output"]] // Export["../figures/llama31_predictions.jpg", #]&


ClassifierMeasurements[
 outputs["openpipe:phosphors-gpt4o-mini"],
 outputs["Dataset Output"]] // Export["../figures/gpt4omini_predictions.jpg", #]&
