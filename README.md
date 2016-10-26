# VxSpaceReport
Script for determining total, free and used space per Veritas DG as well as free chunks per disk

How to run:
Run by hand on the server in question
For each DG it will display:
  name
  total size in GB
  Unused GB
  Free GB
  Used GB
  Breakdown of free space (chunks) per disk - reported in MB
Note:  for Veritas clusters, the last code segment should be commented out from the comment line to the separator line (hashes) as indicated in the script itself.  This is due to the command used (vxassist) having a history of causing issues on cluster nodes - not something you want to run into on a production environment!
