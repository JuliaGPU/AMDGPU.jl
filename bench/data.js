window.BENCHMARK_DATA = {
  "lastUpdate": 1779927005493,
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
          "id": "250313f331cf115c0c2607d88edf56d64db4d4cd",
          "message": "Merge pull request #924\n\nFixes #3037 as tested in #3039",
          "timestamp": "2026-05-27T20:50:13+02:00",
          "tree_id": "247094393005d9ba2a9337cf69b79ccf8f87df1d",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/250313f331cf115c0c2607d88edf56d64db4d4cd"
        },
        "date": 1779913840783,
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
            "value": 85861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 291474,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5008\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 136552,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=241\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 132492,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3920\nallocs=141\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2832319,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96582,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7296\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 289124,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9056\nallocs=376\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 166172,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5536\nallocs=262\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 123572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4608\nallocs=183\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3012111,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 107051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4496\nallocs=178\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1710,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 37680,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1248\nallocs=64\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 96602,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 131041,
            "unit": "ns",
            "extra": "gctime=0\nmemory=960\nallocs=56\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 183463,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12688\nallocs=397\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 194503,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15424\nallocs=474\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 117062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 117102,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170492,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 157163,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16464\nallocs=458\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 353365,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23888\nallocs=723\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289634,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 75051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4736\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4768\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 75732,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 52321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1264\nallocs=70\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57971,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3568\nallocs=139\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 84091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2176\nallocs=136\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 98801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4480\nallocs=205\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 87141,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5024\nallocs=197\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 165922,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2448\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 133612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5088\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 778721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97992,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4832\nallocs=169\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 298384,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8272\nallocs=300\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133871,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95631,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=193\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 783741,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96991,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5520\nallocs=212\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 298854,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7760\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132892,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5072\nallocs=184\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 781031,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4448\nallocs=145\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 299094,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7280\nallocs=238\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95682,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4896\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 783111,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96961,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5184\nallocs=191\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 296104,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6880\nallocs=213\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44180,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424\nallocs=62\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75602,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2336\nallocs=119\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 171753,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1264\nallocs=60\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 57980,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1936\nallocs=102\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52291,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1920\nallocs=85\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102952,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=122\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 125132,
            "unit": "ns",
            "extra": "gctime=0\nmemory=976\nallocs=43\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 108332,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2800\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 341595,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25120\nallocs=871\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 38770,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1360\nallocs=71\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 39940,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1808\nallocs=79\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 164553,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2064\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 238594,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2128\nallocs=78\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5044450,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 55211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 63701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1952\nallocs=106\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1310,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 126582,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2816\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1474749861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11910810987,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10280525735,
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
          "id": "0bdd90039dd2b2a02a868cdbb1294bc32fede197",
          "message": "Merge pull request #923\n\nFix hardware FP atomics on Julia 1.13 (LLVM 20)",
          "timestamp": "2026-05-27T22:04:25+02:00",
          "tree_id": "cb56f3c883e2d454c318b1b5969948094e171bf7",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/0bdd90039dd2b2a02a868cdbb1294bc32fede197"
        },
        "date": 1779920110952,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 610,
            "unit": "ns",
            "extra": "gctime=0\nmemory=48\nallocs=3\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/blocking",
            "value": 240,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16\nallocs=1\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/nonblocking",
            "value": 330,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 87711,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7824\nallocs=271\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 379546,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=259\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 132802,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5472\nallocs=258\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 129732,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2828301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 98321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7680\nallocs=256\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 380465,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6112\nallocs=298\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 164562,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4560\nallocs=201\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 123761,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5152\nallocs=217\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3011164,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 80541,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4512\nallocs=179\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1660,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40460,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1440\nallocs=76\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 181113,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 115712,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 106792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2416\nallocs=147\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 186302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12528\nallocs=383\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 195333,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15376\nallocs=471\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 122102,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116841,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170453,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156782,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16880\nallocs=484\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 356656,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23952\nallocs=727\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 296845,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4448\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74421,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4768\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 75921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5312\nallocs=165\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 50791,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1648\nallocs=94\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3584\nallocs=140\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 85261,
            "unit": "ns",
            "extra": "gctime=0\nmemory=800\nallocs=50\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 147322,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4560\nallocs=210\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 87572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4944\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 107102,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2928\nallocs=167\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134522,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5296\nallocs=198\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 773032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 95502,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5104\nallocs=186\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 296274,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7168\nallocs=231\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134472,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95391,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4352\nallocs=139\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 784532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96102,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5040\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 309564,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=169\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 133822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5088\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 770152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97312,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5056\nallocs=183\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 298664,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7184\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4816\nallocs=168\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 780781,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96671,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 299584,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9808\nallocs=396\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44661,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1280\nallocs=53\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1776\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 165402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1312\nallocs=63\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 56231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1968\nallocs=104\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52161,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2096\nallocs=96\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=122\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 108542,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2848\nallocs=160\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 79521,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2544\nallocs=141\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 346975,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23152\nallocs=748\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39010,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1376\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40291,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1584\nallocs=65\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 135142,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3328\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237813,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4208\nallocs=208\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5030722,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 64211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2128\nallocs=117\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 64431,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1984\nallocs=108\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1270,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 196383,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2976\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1478279778,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11941194783,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10378106261,
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
          "id": "77983ff40f9c30c6d7c8a8fbb1f36450800fb77c",
          "message": "Bump patch",
          "timestamp": "2026-05-27T23:32:43+02:00",
          "tree_id": "e8a9f3700bf4db443b2739476a09c00d20a114e8",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/77983ff40f9c30c6d7c8a8fbb1f36450800fb77c"
        },
        "date": 1779927000997,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 590,
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
            "value": 87811,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7328\nallocs=240\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 403115,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9184\nallocs=384\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135562,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4224\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 130651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4992\nallocs=208\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2830168,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 95162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7456\nallocs=242\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 287554,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6512\nallocs=323\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 163062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5968\nallocs=289\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 122662,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3904\nallocs=139\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3009581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 92571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4240\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1650,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40541,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1200\nallocs=61\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 101241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 171042,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 67061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1200\nallocs=71\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 186323,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12576\nallocs=390\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 193182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15664\nallocs=489\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 116491,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116172,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170953,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 157112,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16848\nallocs=482\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 357464,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23984\nallocs=729\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 297354,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 76211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4624\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 75451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4960\nallocs=169\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77631,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5328\nallocs=166\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 52101,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1440\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57911,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3648\nallocs=144\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 90721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=143\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 79251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3312\nallocs=132\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 94361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4480\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 111361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2976\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=175\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 781590,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97911,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5248\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 296814,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7488\nallocs=251\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 131561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5088\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 785040,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 97011,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4864\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 300435,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7056\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 130022,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95462,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4672\nallocs=159\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 776581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97971,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=205\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 299134,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9776\nallocs=394\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134991,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6128\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95171,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5328\nallocs=200\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 783650,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 97052,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=197\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 298874,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7120\nallocs=228\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44560,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1648\nallocs=76\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 119381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3264\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 79391,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2464\nallocs=135\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1936\nallocs=86\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2896\nallocs=146\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 104651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2784\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 125452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1216\nallocs=58\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 370525,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25968\nallocs=924\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39170,
            "unit": "ns",
            "extra": "gctime=0\nmemory=688\nallocs=29\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40441,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1824\nallocs=80\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 147172,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4320\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 240543,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1840\nallocs=60\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5026059,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 65060,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2128\nallocs=117\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 50911,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1888\nallocs=102\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1280,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 197633,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1952\nallocs=109\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1473646012,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11890085969,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10356361296,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          }
        ]
      }
    ]
  }
}