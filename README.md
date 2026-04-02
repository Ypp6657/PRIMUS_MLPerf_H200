# 🚀 MLPerf Small LLM Pretraining Benchmark on NVIDIA H200 (Primus Framework)

This repository contains my implementation and benchmarking results of **MLPerf Training: Small LLM Pretraining** using the **Primus framework** on **8× NVIDIA H200 GPUs**.

---

## 📌 Project Highlights

- ⚡ MLPerf Small LLM Pretraining Benchmark
- 🧠 Framework: Primus (MoE-based training)
- 🔥 Hardware: 8 × NVIDIA H200 GPUs
- ⏱️ Optimized distributed training (multi-GPU)
- 📊 Achieved target validation loss within MLPerf threshold
- 🧪 Reproducible benchmarking pipeline

---

## 🏗️ System Configuration

| Component | Details |
|----------|--------|
| GPUs | 8 × NVIDIA H200 |
| Nodes | Single Node |
| Framework | Primus |
| Backend | NCCL |
| Precision | FP16 |
| Scheduler | SLURM |

---

## 📂 Repository Structure


configs/ → Training configurations
scripts/ → Execution scripts
docker/ → Container setup
results/ → Benchmark logs & plots
docs/ → Detailed explanation


---

## ⚙️ Setup Instructions

### 1. Clone Repository

```bash
git clone https://github.com/<your-username>/PRIMUS-MLPerf-H200.git
cd PRIMUS-MLPerf-H200
2. Environment Setup
bash scripts/setup_env.sh
3. Run Benchmark
bash scripts/run_and_time.sh
📊 Results
Metric	Value
Target Loss	3.34
Achieved Loss	<your_value>
Step Time	~1.0 sec
GPUs Used	8 × H200
📈 Performance Insights
Efficient scaling across 8 GPUs using NCCL
Stable convergence to MLPerf target loss
Optimized batch size and training steps
🧠 Key Learnings
Deep understanding of MLPerf benchmarking pipeline
Multi-GPU distributed training optimization
Primus MoE architecture internals
HPC cluster execution using SLURM + containers
🚧 Future Work
Multi-node scaling experiments
FP8 / mixed precision optimization
vLLM benchmarking comparison
Automated performance dashboards
🙌 Acknowledgements
MLPerf Training Benchmark
NVIDIA GPU Architecture
Primus Framework
📬 Contact

Yash Pawar
Project Engineer @ CDAC


---

# 📊 5. Add Results Visualization (THIS WILL BOOST YOUR PROFILE 🔥)

Inside `results/plots/` add:

- training loss curve
- throughput graph
- GPU utilization (if possible)

If you want, I can generate **Plotly + Seaborn scripts** for this.

---

# 🧠 6. Add "docs/learnings.md" (THIS IS GOLD)

This is where you stand out from others.

Write things like:

```markdown
## What I Learned

- How MLPerf defines benchmarking standards
- Importance of evaluation frequency
- Distributed training bottlenecks (communication vs compute)
- Effect of batch size on convergence
- GPU scaling challenges
