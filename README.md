# Hail_support_cu_anschutz
This repository hosts scripts and documentation on how to use hail on Alpine. This short tutorial also shows you how to run [hail](https://hail.is/references.html)  as slurm batch jobs on Alpine. Hail has been installed from this page: https://hail.is/docs/0.2/install/linux.html
Note that at the moment you have to open a ticket on Alpine so that Hail can be installed into your filesystem. Here, we see how to run hail interactively using a script of modified from the hail website, but hail can also be run non-interactively.
The hail installation that we use for our example is located in "/pl/active/CCPM/software".

[Hail](https://hail.is/references.html) is a genomic analysis tool that enables distributed parallel computing over multiple computer nodes.
In this guide, we plan to demonstrate how to run hail on Alpine interactively. The python script that we use to demonstrate it was downloaded from [here](https://hail.is/docs/0.2/install/other-cluster.html). Note that the code "slurm-spark-submit" was adapted from the original code "pbs-spark-submit" from the [UNM CARC HPC center](https://lobogit.unm.edu/CARC/tutorials/-/blob/master/spark/pbs-spark-submit).

## Hail utilization steps.

1) Make sure to clone the hail repository that we implemented and go into that directory.
   We choose to this in the scratch directory.

   ```bash
   cd /scratch/alpine/$USER
   git clone https://github.com/kf-cuanschutz/Hail_support_cu_anschutz.git
   cd Hail_support_cu_anschutz

2) Now for this demonstration, our slurm script requests 8 cores per nodes and 2 nodes to demonstrate the parallel distribution.
   The CPU partition to demonstrate slurm batch jobs on Alpine is called "amilan". Please refer to the CU Boulder [page](https://curc.readthedocs.io/en/latest/clusters/alpine/alpine-hardware.html) for more information.
   We request the partition for a walltime of 25 minutes.

   ```bash
   sbatch hail.slurm
   ```
