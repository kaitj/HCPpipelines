#!/bin/bash
set -e

# make pipeline engine happy.
if [ $# -eq 1 ]
	then
		echo "Version unknown..."
		exit 0
fi

StudyFolder="$1"
Subject="$2"
FinalTemplateSpace="$3"
CaretAtlasFolder="$4"
DownSampleI="$5"
DownSampleNameI="$6"
PipelineScripts="$7"
PipelineBinaries="$8"
GlobalScripts="${9}"
Caret5_Command="${10}"
Caret7_Command="${11}"



#Naming Conventions
T1wImage="T1w_acpc_dc"
T1wFolder="T1w" #Location of T1w images
T2wFolder="T2w" #Location of T1w images
T2wImage="T2w_acpc_dc" 
AtlasSpaceFolder="MNINonLinear"
NativeFolder="Native"
FreeSurferFolder="$Subject"
FreeSurferInput="T1w_acpc_dc_restore_1mm"
AtlasTransform="acpc_dc2standard"
InverseAtlasTransform="standard2acpc_dc"
AtlasSpaceT1wImage="T1w_restore"
AtlasSpaceT2wImage="T2w_restore"
T1wRestoreImage="T1w_acpc_dc_restore"
T2wRestoreImage="T2w_acpc_dc_restore"
OrginalT1wImage="T1w"
OrginalT2wImage="T2w"
T1wImageBrainMask="brainmask_fs"
InitialT1wTransform="acpc.mat"
dcT1wTransform="T1w_dc.nii.gz"
InitialT2wTransform="acpc.mat"
dcT2wTransform="T2w_reg_dc.nii.gz"
FinalT2wTransform="${Subject}/mri/transforms/T2wtoT1w.mat"
BiasField="BiasField_acpc_dc"
OutputT1wImage="T1w_acpc_dc"
OutputT1wImageRestore="T1w_acpc_dc_restore"
OutputT1wImageRestoreBrain="T1w_acpc_dc_restore_brain"
OutputMNIT1wImage="T1w"
OutputMNIT1wImageRestore="T1w_restore"
OutputMNIT1wImageRestoreBrain="T1w_restore_brain"
OutputT2wImage="T2w_acpc_dc"
OutputT2wImageRestore="T2w_acpc_dc_restore"
OutputT2wImageRestoreBrain="T2w_acpc_dc_restore_brain"
OutputMNIT2wImage="T2w"
OutputMNIT2wImageRestore="T2w_restore"
OutputMNIT2wImageRestoreBrain="T2w_restore_brain"
OutputOrigT1wToT1w="OrigT1w2T1w.nii.gz"
OutputOrigT1wToStandard="OrigT1w2standard.nii.gz" #File was OrigT2w2standard.nii.gz, regnerate and apply matrix
OutputOrigT2wToT1w="OrigT2w2T1w.nii.gz" #mv OrigT1w2T2w.nii.gz OrigT2w2T1w.nii.gz
OutputOrigT2wToStandard="OrigT2w2standard.nii.gz"
BiasFieldOutput="BiasField"

T1wFolder="$StudyFolder"/"$Subject"/"$T1wFolder" 
T2wFolder="$StudyFolder"/"$Subject"/"$T2wFolder" 
AtlasSpaceFolder="$StudyFolder"/"$Subject"/"$AtlasSpaceFolder"
FreeSurferFolder="$T1wFolder"/"$FreeSurferFolder"
AtlasTransform="$AtlasSpaceFolder"/xfms/"$AtlasTransform"
InverseAtlasTransform="$AtlasSpaceFolder"/xfms/"$InverseAtlasTransform"

#Conversion of FreeSurfer Volumes and Surfaces to NIFTI and GIFTI and Create Caret Files and Registration
# # # # "$PipelineScripts"/FreeSurfer2CaretConvertAndRegisterNonlinear.sh "$StudyFolder" "$Subject" "$T1wFolder" "$AtlasSpaceFolder" "$NativeFolder" "$FreeSurferFolder" "$FreeSurferInput" "$FinalTemplateSpace" "$T1wRestoreImage" "$T2wRestoreImage" "$CaretAtlasFolder" "$DownSampleI" "$DownSampleNameI" "$Caret5_Command" "$Caret7_Command" "$AtlasTransform" "$InverseAtlasTransform" "$AtlasSpaceT1wImage" "$AtlasSpaceT2wImage" "$T1wImageBrainMask" "$PipelineScripts" "$GlobalScripts"

# # # # #Create FreeSurfer ribbon file at full resolution
# # # # "$PipelineScripts"/CreateRibbon.sh "$StudyFolder" "$Subject" "$T1wFolder" "$AtlasSpaceFolder" "$NativeFolder" "$Caret7_Command" "$AtlasSpaceT1wImage" "$T1wRestoreImage"

#Myelin Mapping
"$PipelineScripts"/CreateMyelinMaps.sh "$StudyFolder" "$Subject" "$AtlasSpaceFolder" "$NativeFolder" "$T1wFolder" "$DownSampleNameI" "$Caret5_Command" "$Caret7_Command" "$T1wFolder"/"$OrginalT1wImage" "$T2wFolder"/"$OrginalT2wImage" "$T1wFolder"/"$T1wImageBrainMask" "$T1wFolder"/xfms/"$InitialT1wTransform" "$T1wFolder"/xfms/"$dcT1wTransform" "$T2wFolder"/xfms/"$InitialT2wTransform" "$T1wFolder"/xfms/"$dcT2wTransform" "$T1wFolder"/"$FinalT2wTransform" "$AtlasTransform" "$T1wFolder"/"$BiasField" "$T1wFolder"/"$OutputT1wImage" "$T1wFolder"/"$OutputT1wImageRestore" "$T1wFolder"/"$OutputT1wImageRestoreBrain" "$AtlasSpaceFolder"/"$OutputMNIT1wImage" "$AtlasSpaceFolder"/"$OutputMNIT1wImageRestore" "$AtlasSpaceFolder"/"$OutputMNIT1wImageRestoreBrain" "$T1wFolder"/"$OutputT2wImage" "$T1wFolder"/"$OutputT2wImageRestore" "$T1wFolder"/"$OutputT2wImageRestoreBrain" "$AtlasSpaceFolder"/"$OutputMNIT2wImage" "$AtlasSpaceFolder"/"$OutputMNIT2wImageRestore" "$AtlasSpaceFolder"/"$OutputMNIT2wImageRestoreBrain" "$T1wFolder"/xfms/"$OutputOrigT1wToT1w" "$T1wFolder"/xfms/"$OutputOrigT1wToStandard" "$T1wFolder"/xfms/"$OutputOrigT2wToT1w" "$T1wFolder"/xfms/"$OutputOrigT2wToStandard" "$AtlasSpaceFolder"/"$BiasFieldOutput" "$AtlasSpaceFolder"/"$T1wImageBrainMask"



