export CUDA_VISIBLE_DEVICES=0
seq_l=12


for model_name in DPG_Mixer
do
for data_name in PEMS08 PeMS-Bay
do
for pred_l in 12 
do
for rate in 1e-3 5e-3 1e-4 1e-5 5e-5
do
python -u main.py \
    --model_name $model_name \
    --exp_name 'deep_learning'\
    --data_name $data_name \
    --train True\
    --resume False\
    --seq_len $seq_l\
    --pred_len $pred_l\
    --lr $rate \
    --patience 5 \
    --end_epoch 150 \
    --batch_size 32 \
    --resume_dir None\
    --output_dir None\
    --info '5.29 baselines'\

done
done
done
done