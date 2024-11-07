#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory@ NotebookDirectory[];
d = Import["../data/Inorganic_Phosphor_Optical_Properties_DB.xlsx","Dataset", 
			HeaderLines->1][[1]];

(* create histogram of emission wavelengths *)
Histogram[
  Normal@ d[All, "Emission max. (nm)"],
  Frame->True, FrameLabel->{"Emission max. (nm)", "Count"}] // 
    Export["../figures/emission_distribution.jpg", #]&


(* map wavelengths into standard color names *)
colorName[wavelength_?(Between[{313,380}])] := "Ultraviolet"
colorName[wavelength_?(Between[{380,450}])] := "Violet"
colorName[wavelength_?(Between[{450,495}])] := "Blue"
colorName[wavelength_?(Between[{495,570}])] := "Green"
colorName[wavelength_?(Between[{570,590}])] := "Yellow"
colorName[wavelength_?(Between[{590,620}])] := "Orange"
colorName[wavelength_?(Between[{620,750}])] := "Red"
colorName[wavelength_?(Between[{750,1120}])] := "Infrared"
colorName[""] := Missing[]

(* extract data into pairs of formula -> color *)
format[row_] := (row["Inorganic phosphor"]-> colorName[row["Emission max. (nm)"]])

(* apply function to reformat the data, deleting any cases where wavelength is missing *)
dd = Normal@ DeleteMissing@ Map[format]@d;

(* create visualization of the different emission colors *) 
PieChart[
  Values@ Counts@ dd[[All, 2]],
  ChartLabels->(Keys@ Counts@ dd[[All, 2]]),
  ChartStyle->{Orange, Green, LightBlue, Purple, Red, Yellow, LightPurple, LightRed}] //
	 Export["../figures/emission_colors.jpg", #]&


(* export data *)
SeedRandom[2024];
{train, test} = ResourceFunction["TrainTestSplit"][dd]

Export["../data/train.txt", train]
Export["../data/test.txt", test]

DumpSave["../data/split.mx", {train,test}]



