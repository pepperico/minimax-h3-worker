FROM runpod/worker-comfyui:5.10.0-base-cuda12.8.1

# MiniMax H3 (open-weight, released 2026-08-03) — text-to-video with native audio.
# ComfyUI core nodes for this ship in 0.33.0+; this base image carries 0.34.0, so no
# custom node install is needed, only the model weights.

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors \
    --relative-path models/diffusion_models \
    --filename minimax_h3_fl2va_pruned_int8_convrot.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors \
    --relative-path models/text_encoders \
    --filename qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_video_vae_fp16.safetensors \
    --relative-path models/vae \
    --filename minimax_h3_video_vae_fp16.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_audio_vae_fp32.safetensors \
    --relative-path models/vae \
    --filename minimax_h3_audio_vae_fp32.safetensors

RUN comfy model download \
    --url https://huggingface.co/lightx2v/Minimax-h3-Turbo/resolve/main/minimax_h3_fl2v_turbo_8step_v1.0_comfyui_bf16.safetensors \
    --relative-path models/loras \
    --filename minimax_h3_fl2v_turbo_8step_v1.0_comfyui_bf16.safetensors

# Ref2VA checkpoint — for MiniMaxH3ReferenceToVideo (up to 9 reference images + video/audio).
# Separate from the FL2VA checkpoint above; only one is loaded at a time depending on
# which workflow/node is used, so this only adds build/pull time, not runtime VRAM.
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/diffusion_models/minimax_h3_ref2va_pruned_int8_convrot.safetensors \
    --relative-path models/diffusion_models \
    --filename minimax_h3_ref2va_pruned_int8_convrot.safetensors

# Upscale models, carried over from the earlier pod-based setup.
RUN comfy model download \
    --url https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth \
    --relative-path models/upscale_models \
    --filename RealESRGAN_x4plus.pth

RUN comfy model download \
    --url https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth \
    --relative-path models/upscale_models \
    --filename 4x-UltraSharp.pth
