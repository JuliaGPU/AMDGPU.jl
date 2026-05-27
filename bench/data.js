window.BENCHMARK_DATA = {
  "lastUpdate": 1779882620349,
  "repoUrl": "https://github.com/JuliaGPU/AMDGPU.jl",
  "entries": {
    "AMDGPU.jl Benchmarks": [
      {
        "commit": {
          "author": {
            "email": "61313342+luraess@users.noreply.github.com",
            "name": "Ludovic Räss",
            "username": "luraess"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "0126808a4bf6e1e4964666f272f7841c3a9b6b13",
          "message": "Update README to include benchmark badge",
          "timestamp": "2026-05-26T10:49:38+02:00",
          "tree_id": "cae8fef112edde8393cfae850446cc70c38fbd57",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/0126808a4bf6e1e4964666f272f7841c3a9b6b13"
        },
        "date": 1779800319345,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 600,
            "unit": "ns",
            "extra": "gctime=0\nmemory=48\nallocs=3\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/blocking",
            "value": 250,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16\nallocs=1\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/nonblocking",
            "value": 340,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 87182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7808\nallocs=270\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 271554,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4240\nallocs=181\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 200593,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5696\nallocs=272\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 143512,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5456\nallocs=237\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 3119624,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7344\nallocs=235\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 287924,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=241\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 219753,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3840\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 134452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5392\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3331236,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 147062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=205\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1700,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40270,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424\nallocs=75\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114632,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 115252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 65751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1904\nallocs=115\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 184083,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12432\nallocs=381\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 194252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15344\nallocs=469\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 155212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 158003,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 169343,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156642,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16864\nallocs=483\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 354395,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24000\nallocs=730\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289084,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 75061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4464\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 75101,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4864\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 91941,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5568\nallocs=181\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 52341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1504\nallocs=85\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57881,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3680\nallocs=146\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 91841,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1664\nallocs=104\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 145872,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4432\nallocs=202\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 95632,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4992\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 141912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2880\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 131362,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 91142,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 641299,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 100221,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5136\nallocs=188\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 272184,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7392\nallocs=245\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 132262,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 92201,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5376\nallocs=203\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 648459,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 97561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5184\nallocs=191\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 275514,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6896\nallocs=214\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 131142,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 91302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5360\nallocs=202\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 640429,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 100612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4176\nallocs=128\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 273254,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9696\nallocs=389\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 131622,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 91901,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4192\nallocs=129\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 646759,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 97821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4960\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 276334,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6512\nallocs=190\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1616\nallocs=74\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 108901,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2672\nallocs=148\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 78001,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2480\nallocs=136\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52430,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1968\nallocs=88\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101351,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2480\nallocs=120\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 153163,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2720\nallocs=152\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 136722,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3248\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 340015,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24224\nallocs=815\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39350,
            "unit": "ns",
            "extra": "gctime=0\nmemory=400\nallocs=11\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40081,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1120\nallocs=36\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 159783,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1536\nallocs=50\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 239233,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4800\nallocs=245\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5037681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 63751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2096\nallocs=115\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 50661,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1840\nallocs=99\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1280,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 198073,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3040\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1483849116,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11969055254,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10252972590,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "61313342+luraess@users.noreply.github.com",
            "name": "Ludovic Räss",
            "username": "luraess"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "30db2ccfc49d7ad348bd242033313b43665828fb",
          "message": "Merge pull request #921\n\nrocBLAS fixes for 1.13",
          "timestamp": "2026-05-26T18:50:49+02:00",
          "tree_id": "dd34ffe52202ef78f19579a14a92d6ef75a6e68b",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/30db2ccfc49d7ad348bd242033313b43665828fb"
        },
        "date": 1779848643395,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 600,
            "unit": "ns",
            "extra": "gctime=0\nmemory=48\nallocs=3\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/blocking",
            "value": 250,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16\nallocs=1\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/nonblocking",
            "value": 340,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 87912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7168\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 377806,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9184\nallocs=384\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 132962,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4816\nallocs=217\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 130232,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=226\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2828730,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 94792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7744\nallocs=260\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 296295,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5024\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 168273,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4864\nallocs=220\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 124332,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4560\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3012253,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 91621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4240\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1740,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 38370,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1392\nallocs=73\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114781,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 115392,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 59901,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1440\nallocs=86\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 183663,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12528\nallocs=387\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 191663,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15392\nallocs=472\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 116691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170762,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156362,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16976\nallocs=490\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 358726,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23936\nallocs=726\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 297164,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74201,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4704\nallocs=178\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74851,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4224\nallocs=123\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77271,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5344\nallocs=167\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1520\nallocs=86\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3872\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 74771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2064\nallocs=129\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 93162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3392\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 92041,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5008\nallocs=196\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 84951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2752\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134042,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4336\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 778621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5008\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 299124,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9840\nallocs=398\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95752,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4704\nallocs=161\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 782442,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96952,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5392\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 300554,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7040\nallocs=223\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 134001,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5104\nallocs=186\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 775212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5440\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 303524,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7376\nallocs=244\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134762,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4352\nallocs=139\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 782341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96752,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 300534,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7184\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1696\nallocs=79\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1904\nallocs=92\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 139412,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3216\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 74861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=65\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52100,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1680\nallocs=70\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2464\nallocs=119\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 179532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2688\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 115342,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2368\nallocs=130\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 343644,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23392\nallocs=763\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39161,
            "unit": "ns",
            "extra": "gctime=0\nmemory=656\nallocs=27\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40220,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1856\nallocs=82\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 143882,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3840\nallocs=194\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237113,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2096\nallocs=76\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5034652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 107302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2448\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 46721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1808\nallocs=97\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1290,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 123912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2800\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1470667415,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11877284792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10304855031,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          }
        ]
      },
      {
        "commit": {
          "author": {
            "email": "61313342+luraess@users.noreply.github.com",
            "name": "Ludovic Räss",
            "username": "luraess"
          },
          "committer": {
            "email": "noreply@github.com",
            "name": "GitHub",
            "username": "web-flow"
          },
          "distinct": true,
          "id": "83f3bc4b97e93772d0a75c03da30d8fb9e9d61a2",
          "message": "Merge pull request #925\n\nBump action in Benchmark CI",
          "timestamp": "2026-05-27T11:59:58+02:00",
          "tree_id": "bd397e237af0e575d2b01b2c37f2d3f98db0322f",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/83f3bc4b97e93772d0a75c03da30d8fb9e9d61a2"
        },
        "date": 1779882472889,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 600,
            "unit": "ns",
            "extra": "gctime=0\nmemory=48\nallocs=3\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/blocking",
            "value": 260,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16\nallocs=1\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/nonblocking",
            "value": 340,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 86611,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7296\nallocs=238\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 375776,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9184\nallocs=384\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 133262,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4832\nallocs=218\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 131222,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5696\nallocs=252\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2829588,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 95731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7328\nallocs=234\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 376505,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=242\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 163052,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5104\nallocs=235\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 125072,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4496\nallocs=176\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3014311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 131302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4896\nallocs=203\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1641,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 38571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=896\nallocs=42\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 182862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 115422,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 130492,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2176\nallocs=132\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 184583,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12416\nallocs=380\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 196023,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15344\nallocs=469\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 114221,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 115272,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 168872,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 155132,
            "unit": "ns",
            "extra": "gctime=0\nmemory=17008\nallocs=492\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 353805,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24032\nallocs=732\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289444,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 73281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4400\nallocs=159\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4560\nallocs=144\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 76301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5296\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 50971,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1264\nallocs=70\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3600\nallocs=141\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 143202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1008\nallocs=63\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 88771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4512\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 84951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5040\nallocs=198\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 135612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1600\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 132482,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 94481,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 773180,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 96441,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5328\nallocs=200\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 297535,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7232\nallocs=235\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 93921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5168\nallocs=190\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 782071,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 95861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=175\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 298634,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7456\nallocs=249\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132772,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6368\nallocs=197\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 94531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5056\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 775890,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8688\nallocs=364\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 96371,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4944\nallocs=166\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 299124,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7680\nallocs=263\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 132992,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 94981,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5456\nallocs=208\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 780301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96031,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5744\nallocs=226\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 296644,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6928\nallocs=216\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1472\nallocs=65\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 74731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2032\nallocs=100\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 109032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1456\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 76531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1568\nallocs=79\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 51860,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2080\nallocs=95\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3072\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 106691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2912\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 84751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2448\nallocs=135\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 340835,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24352\nallocs=823\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 38860,
            "unit": "ns",
            "extra": "gctime=0\nmemory=992\nallocs=48\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 39821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 158692,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1184\nallocs=28\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 236374,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3008\nallocs=133\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5046138,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 63551,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2112\nallocs=116\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 125251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2832\nallocs=161\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1270,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 196763,
            "unit": "ns",
            "extra": "gctime=0\nmemory=880\nallocs=42\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1480805647,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11952403030,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10336415505,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          }
        ]
      }
    ]
  }
}