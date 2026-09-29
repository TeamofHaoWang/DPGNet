export CUDA_VISIBLE_DEVICES=0

seq_l=12
pred_l=12
batch_size=32
patience=5
end_epoch=100
num_workers=0
model_name=DPG_Mixer


for data_name in PeMS-Bay
do
for tau in 0 0.005 0.010 0.025 0.050 0.100 0.200
do
for rate in 1e-3 5e-3 1e-4 1e-5 5e-5
do
for seed in 21
do

python -u main.py \
    --model_name ${model_name} \
    --exp_name 'deep_learning' \
    --data_name ${data_name} \
    --train True \
    --resume False \
    --seq_len ${seq_l} \
    --pred_len ${pred_l} \
    --lr ${rate} \
    --patience ${patience} \
    --end_epoch ${end_epoch} \
    --batch_size ${batch_size} \
    --num_workers ${num_workers} \
    --seed ${seed} \
    --graph_threshold ${tau} \
    --resume_dir None \
    --output_dir None \
    --info "tau sensitivity ${data_name} tau=${tau} lr=${rate} seed=${seed}"

done
done
done
done
