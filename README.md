# orthofindR
This R package enables quick orthology searches between any two species in the ENSEMBL database with little coding experience necessary. 

The packages wraps around biomaRt from Ensembl. 

The user specifies the latin name of the starting organism (input_org, ex: "ggallus") and can recieve back the unique ensembl IDs and all homology information for a target organism (output_org, ex: "hsapiens") or list of organisms. 

The user can also specify if they want to return only orthologus that have a one-to-one match across species. 

