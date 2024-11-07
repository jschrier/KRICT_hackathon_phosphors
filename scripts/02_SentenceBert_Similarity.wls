#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory@ NotebookDirectory[]

(* import our train/test split *)
<<"../data/split.mx"


(* create a vector similarity search; we'll just use a local sentence BERT model (default)
applied to the composition formulas.  *)
db = CreateSemanticSearchIndex[ train, "phosphors"]


(* by default, SemanticSearch will return the 10 nearest items*) 

predicted = ParallelMap[SemanticSearch[db, #]&, test[[All, 1]]];
actual = test[[All, 2]];


ClassifierMeasurements[First/@predicted, actual] //
	Export["../figures/nearest_sentenceBERT_similarity.jpg", #]&


ClassifierMeasurements[First/@Commonest/@predicted, actual] //
	Export["../figures/commonest_sentenceBERT_similarity.jpg", #]&
