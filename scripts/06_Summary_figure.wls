#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory@ NotebookDirectory[];

BarChart[
	{Labeled[85.1, "Fine-tuned gpt-4o-mini", Right],
	 Labeled[84.4, "Fine-tuned Llama-3.1-8B", Right],
	 Labeled[80.3, "SentenceBERT nearest", Right],
	 Labeled[79.0, "String Edit nearest", Right],
	 Labeled[34.4, "Guess majority", Right]},
	BarOrigin->Left,
	ChartStyle->{Pink, LightRed, Orange, LightOrange, LightGray},
	Frame->True, FrameLabel->"% Accuracy"] // 
		Export["../figures/summary_barchart.jpg", #]&
