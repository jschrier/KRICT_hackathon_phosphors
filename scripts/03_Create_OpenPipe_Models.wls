#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory@NotebookDirectory[];

<<"../src/finetuning.wl"
<<"../data/split.mx"


system = "You are an expert materials chemist predicting the emission color of a phosphor with the chemical composition provided.  Answer only with the following color names and no other output: Ultraviolet, Violet, Blue, Green, Yellow, Orange, Red, Infrared.";

tr = formatChatML[system, #]&/@train;
te = formatChatML[system, #]&/@test;


exportChatML["../data/train.jsonl", tr]
exportChatML["../data/test.jsonl", te]

exportOpenPipeChatML["../data/openpipe.jsonl", tr, te]

(* after this, upload the file to Openpipe.ai and initiate fine tunings...*)




