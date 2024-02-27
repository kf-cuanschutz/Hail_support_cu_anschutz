#SBATCH --job-name=hail_demonstration
#SBATCH --account=amc-general
#SBATCH --partition=amilan
#SBATCH --output=hail_demonstration.out
#SBATCH --error=hail_demonstration.err
#SBATCH --qos=normal
#SBATCH --time=00:25:00
#SBATCH --ntasks-per-node=32 # Ideally the same amount of core requested per node for consistency purpose
#SBATCH --nodes=2


#We want to export correctly the TMP_DIR

export TMP=/gpfs/alpine1/scratch/$USER/cache_dir
mkdir -pv $TMP
export TEMP=$TMP
export TMPDIR=$TMP
export TEMPDIR=$TMP
export PIP_CACHE_DIR=$TMP


# Append the path to the lmod file. For pozdeyevlab allocation it will be instead
# module use --append /pl/active/pozdeyevlab/software/lmod-files

module use --append /pl/active/CCPM/software/lmod-files

# Loading the hail module 
module load hail

# We want the name of the nodes we requested
scontrol show hostname > $SLURM_SUBMIT_DIR/nodelist.txt
export SLURM_NODEFILE=$SLURM_SUBMIT_DIR/nodelist.txt

# We submit hail with the custom made slurm-spark-submit which was modified from: https://lobogit.unm.edu/CARC/tutorials/-/blob/master/spark/pbs-spark-submit
# The hail script was modified from https://hail.is/docs/0.2/install/other-cluster.html
#
python slurm-spark-submit \
--jars $HAIL_HOME/backend/hail-all-spark.jar \
--conf spark.driver.extraClassPath=$HAIL_HOME/backend/hail-all-spark.jar \
--conf spark.executor.extraClassPath=./hail-all-spark.jar \
--conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
--conf spark.kryo.registrator=is.hail.kryo.HailKryoRegistrator hail-script.py --temp_dir $TMP

