import hail as hl
import argparse

# Original code from https://hail.is/docs/0.2/install/other-cluster.html

# Getting the tmp dir path
parser = argparse.ArgumentParser()
parser.add_argument("--temp_dir", help="To enter a temp directory otherwise it will crash")
args = parser.parse_args()
temp_dir = args.temp_dir

#temp_dir = "/gpfs/alpine1/scratch/kfotso@xsede.org/cache_dir"

hl.init(tmp_dir=temp_dir,
        local_tmpdir=temp_dir,
          spark_conf={"spark.local.dir": temp_dir})

mt = hl.balding_nichols_model(n_populations=3,
                              n_samples=500,
                              n_variants=500_000,
                              n_partitions=32)
mt = mt.annotate_cols(drinks_coffee = hl.rand_bool(0.33))
gwas = hl.linear_regression_rows(y=mt.drinks_coffee,
                                 x=mt.GT.n_alt_alleles(),
                                 covariates=[1.0])
gwas.order_by(gwas.p_value).show(25)
