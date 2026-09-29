export CUDA_VISIBLE_DEVICES=0

seq_l=12
pred_l=12
batch_size=32
num_workers=0
model_name=DPG_Mixer
results_dir=./results/tau_sensitivity


eval_one () {
    data_name=$1
    tau=$2
    seed=$3
    exp_name=$4
    checkpoint=./experiments/${exp_name}/${model_name}/${data_name}_best_model.pkl
    hparam=./experiments/${exp_name}/hparam.yaml

    python -u analysis/evaluate_tau_sensitivity_run.py \
        --model_name ${model_name} \
        --data_name ${data_name} \
        --checkpoint ${checkpoint} \
        --hparam ${hparam} \
        --output_dir ${results_dir} \
        --seq_len ${seq_l} \
        --pred_len ${pred_l} \
        --batch_size ${batch_size} \
        --num_workers ${num_workers} \
        --seed ${seed} \
        --graph_threshold ${tau}
}


# After selecting the best exp for each tau from results/tau_sensitivity_train_logs.csv,
# fill one eval_one command per selected run.
#
# Example:
# eval_one METR-LA 0 21 exp10
# eval_one METR-LA 0.005 21 exp11
# eval_one METR-LA 0.010 21 exp12
# eval_one METR-LA 0.025 21 exp13
# eval_one METR-LA 0.050 21 exp14
# eval_one METR-LA 0.100 21 exp15
# eval_one METR-LA 0.200 21 exp16
# eval_one PeMS-Bay 0 21 exp20
# eval_one PeMS-Bay 0.005 21 exp21


python -u analysis/aggregate_tau_sensitivity.py \
    --results_dir ${results_dir}
