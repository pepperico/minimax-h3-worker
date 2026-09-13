# MiniMax H3 — RunPod Serverless Worker

Custom image for running [MiniMax H3](https://huggingface.co/Comfy-Org/MiniMax-H3)
(open-weight text/image/audio-to-video, released 2026-08-03) as a RunPod Serverless
ComfyUI endpoint.

Built on the official [`runpod-workers/worker-comfyui`](https://github.com/runpod-workers/worker-comfyui)
base image, with the MiniMax H3 model files baked in via `comfy model download` at build
time. No custom nodes needed — the base's ComfyUI 0.34.0 has the required core nodes.

Deployed via RunPod's [GitHub integration](https://docs.runpod.io/serverless/github-integration):
RunPod builds and hosts the image itself on every push, no local Docker required.

## Models baked in

- `minimax_h3_fl2va_pruned_int8_convrot.safetensors` (diffusion model, ~19.5GB)
- `qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors` (text encoder, ~14.6GB)
- `minimax_h3_video_vae_fp16.safetensors` / `minimax_h3_audio_vae_fp32.safetensors` (VAE)
- `minimax_h3_fl2v_turbo_8step_v1.0_comfyui_bf16.safetensors` (turbo LoRA)
- `RealESRGAN_x4plus.pth` / `4x-UltraSharp.pth` (upscale models, carried over from an
  earlier pod-based setup)

## Usage

POST the ComfyUI workflow (API format) to the endpoint's `/run` or `/runsync`, per
[worker-comfyui's usage docs](https://github.com/runpod-workers/worker-comfyui#usage).
The `video_minimax_h3_t2v` workflow template (from
[`Comfy-Org/workflow_templates`](https://github.com/Comfy-Org/workflow_templates/blob/main/templates/video_minimax_h3_t2v.json))
needs converting from its editor/canvas format to the flat API format first
(ComfyUI: load it, then `Workflow > Export (API)`).
