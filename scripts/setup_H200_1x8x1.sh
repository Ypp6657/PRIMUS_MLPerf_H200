#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "${SCRIPT_DIR}"

export CONT="${CONT:-primus_moe:updated}"
export BENCH_ROOT="${BENCH_ROOT:-${SCRIPT_DIR}/benchmarks/H200_1x8x1}"
export DATADIR="${DATADIR:-${BENCH_ROOT}/data}"
export MODELDIR="${MODELDIR:-${BENCH_ROOT}/model}"
export LOGDIR="${LOGDIR:-${BENCH_ROOT}/results}"
export NEXP="${NEXP:-1}"

mkdir -p "${DATADIR}" "${MODELDIR}" "${LOGDIR}"
chmod 777 "${LOGDIR}" || true

echo "Benchmark root: ${BENCH_ROOT}"
echo "DATADIR: ${DATADIR}"
echo "MODELDIR: ${MODELDIR}"
echo "LOGDIR: ${LOGDIR}"
echo "Container tag: ${CONT}"
echo "Experiments: ${NEXP}"
echo
echo "Build command:"
echo "  docker build -f Dockerfile.nvidia -t ${CONT} ."
echo
echo "If your dataset already lives elsewhere, override DATADIR before running this script."
echo "Example:"
echo "  DATADIR=/data/gpt_oss_20b/data MODELDIR=${MODELDIR} LOGDIR=${LOGDIR} CONT=${CONT} source ./setup_H200_1x8x1.sh"
echo
echo "To launch:"
echo "  source ./config_H200_1x8x1.sh"
echo "  bash ./run_with_docker.sh"
