MLPerf-Style GPT-OSS-20B MoE Benchmark on NVIDIA H200 (Primus Framework)

🧠 1. Objective

The goal of this project was to:

Successfully build and execute the GPT-OSS 20B Mixture of Experts (MoE) pretraining benchmark
Use Primus + Megatron-LM framework
Run on 8× NVIDIA H200 GPUs (Single Node)
Achieve a valid MLPerf-style benchmark execution

✅ Key Requirements
Correct distributed training pipeline
Stable execution across GPUs
Convergence to target loss (~3.34)
Proper logging and throughput tracking

🏗️ 2. System Setup
💻 Hardware
1 Node
8 × NVIDIA H200 GPUs (~141GB each)
🧩 Software
Docker-based environment
Primus Framework
Megatron-LM backend
MLPerf logging (primus_mllog)

📁 3. Repository Structure
configs/        → Training configuration (H200 setup)
scripts/        → Execution + setup scripts
docker/         → Docker build files
model/          → Tokenizer files
results/        → Benchmark outputs
docs/           → Technical notes & learnings

🐳 4. Docker Build Debugging
🚨 Initial Issue

During Docker build:

patch does not apply

Specifically:

primus_evaluator.patch failed
🧠 Root Cause
Patch was written for an older commit
Repository main branch had changed
Patch and codebase were incompatible
🔧 Incorrect Attempt
git apply --3way patch
Build succeeded ✅
Runtime failed ❌
🚨 Runtime Errors
free(): double free detected
CUDA OOM
Unstable execution

👉 Cause: Patch mismatch with codebase

🔍 5. Correct Debugging Approach
Step 1 — Analyze Patch
sed -n '1,120p' patches/primus_evaluator.patch
Step 2 — Inspect Git History
git log --all -- evaluator.py
Step 3 — Brute-force Commit Search
for c in $(git rev-list --all); do
 git checkout $c
 git apply --check primus_evaluator.patch
 if [ $? -eq 0 ]; then
   echo "FOUND COMMIT: $c"
   break
 fi
done
🎯 Solution
FOUND COMMIT: 96f1bfd82aa436e017ffd495e62841dda8191378
✅ Final Fix
git checkout 96f1bfd82aa436e017ffd495e62841dda8191378
git apply primus_evaluator.patch
🚀 Docker Build Success
docker build --network=host \
 -f Dockerfile.nvidia \
 -t primus_moe_h200:patched .

✔ Patch applied correctly
✔ Image built successfully

🚀 6. Training Setup
Environment
source config_H200_1x8x1.sh
Variables
export CONT=primus_moe_h200:patched
export DATADIR=...
export MODELDIR=...
export LOGDIR=...
🧠 Critical Memory Fix
export PRIMUS_MICRO_BATCH_SIZE=1
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

✔ Resolved CUDA OOM

🧠 7. OOM Debugging
❌ Problem
GPU usage ~134GB
CUDA Out of Memory
🔍 Root Cause
Sequence length: 8192
MoE (8 experts)
Micro-batch size = 2
✅ Fix
PRIMUS_MICRO_BATCH_SIZE=1
📊 Result
Metric	Before	After
Memory	~134GB	~100–115GB
Stability	OOM	Stable
🧾 8. SLURM Execution
sbatch run_h200_moe.sh
Features
Automatic log archiving
Timestamp-based run tracking
Clean environment execution
📊 9. Training Behavior
Training Loss
11 → 10 → 5 → 3.5 → 3.3
Evaluation Loss
3.54 → 3.19
🎯 Target
3.34 (MLPerf threshold)

✔ Achieved convergence

⚡ Throughput
Average: ~9 samples/sec
Minimum: 8.62 samples/sec
🧠 10. Key Learnings
🔹 Train vs Eval Loss
Train loss → noisy
Eval loss → true convergence
🔹 Evaluation Strategy
Periodic evaluation (not end-only)
Controls stopping condition
🔹 Early Stopping

Stops when:

eval_loss ≤ 3.34
⚠️ 11. Issues & Fixes
Issue	Resolution
Patch mismatch	Checkout correct commit
3-way patch misuse	Avoided
Docker runtime issues	Fixed patch alignment
CUDA OOM	Reduced micro-batch
Cache clearing issues	Disabled
SLURM instability	Clean execution
🎯 12. Final Outcome
✅ Docker image built successfully
✅ Patch correctly applied
✅ Training runs on 8× H200
✅ Memory optimized
✅ MLPerf logging working
✅ Throughput measured
✅ Convergence achieved (~3.19 loss)
🚀 13. Conclusion

This project demonstrates:

🔥 End-to-end deployment of a 20B MoE LLM pretraining benchmark on a high-performance GPU cluster.

Key Highlights
Advanced debugging of patch–code mismatch
Deep understanding of distributed MoE training
Efficient utilization of H200 GPUs
Transition from debugging → production benchmarking


👨‍💻 Author

Yash Pawar
Project Engineer @ CDAC
HPC | Distributed Training | LLM Systems
