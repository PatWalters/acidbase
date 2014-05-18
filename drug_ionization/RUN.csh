#!/bin/csh

../make_sdf.py chembl_drugs.smi chembl_drugs.sdf
../charge_state.py chembl_drugs.sdf > chembl_drugs.charge_state
./format_drug_pka.py 

