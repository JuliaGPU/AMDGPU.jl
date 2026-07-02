window.BENCHMARK_DATA = {
  "lastUpdate": 1782985452458,
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
          "id": "25220eff7f7fe26c1b41a415828f3a8a06b204ef",
          "message": "Merge pull request #906\n\nAdd `SparseMatricesCSR.jl` Ext",
          "timestamp": "2026-05-30T22:31:33+02:00",
          "tree_id": "7cd67e96cc37ea72aa4d61c57dd5f7a030782e6a",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/25220eff7f7fe26c1b41a415828f3a8a06b204ef"
        },
        "date": 1780178296957,
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
            "value": 87631,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7632\nallocs=259\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 375736,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3824\nallocs=155\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135662,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4672\nallocs=208\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 129422,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5040\nallocs=211\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2827852,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 98202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7792\nallocs=263\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 285384,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5552\nallocs=263\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 165682,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5360\nallocs=251\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 123622,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4592\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3014765,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 96681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4208\nallocs=160\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1610,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40671,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1376\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 182643,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 182822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 46490,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1488\nallocs=89\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 186003,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12464\nallocs=383\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 194933,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15712\nallocs=492\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 117332,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 115502,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 171443,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 153872,
            "unit": "ns",
            "extra": "gctime=0\nmemory=17504\nallocs=523\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 357705,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23968\nallocs=728\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 297425,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4256\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74021,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4976\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77072,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4864\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 54241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1152\nallocs=63\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 58641,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3456\nallocs=132\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 125432,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2240\nallocs=140\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 92581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4320\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 95831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5472\nallocs=225\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 120041,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3520\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 133992,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95521,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5648\nallocs=220\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 775571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5344\nallocs=201\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 296795,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9712\nallocs=390\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134422,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95502,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5056\nallocs=183\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 783212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96722,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 297634,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7536\nallocs=254\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 134122,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=193\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 773862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97472,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5584\nallocs=216\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 299094,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9792\nallocs=395\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95322,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5184\nallocs=191\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781932,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5424\nallocs=206\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 299634,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6768\nallocs=206\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44901,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1808\nallocs=86\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2688\nallocs=141\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 110231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2528\nallocs=139\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 86432,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2704\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2144\nallocs=99\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101881,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2768\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 125742,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2880\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 121082,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 343075,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24512\nallocs=833\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39261,
            "unit": "ns",
            "extra": "gctime=0\nmemory=592\nallocs=23\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40401,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1680\nallocs=71\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 145782,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3248\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237353,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4624\nallocs=234\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5030063,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 64531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2112\nallocs=116\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 64991,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2144\nallocs=118\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1280,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 197133,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2800\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1479797436,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11924116361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10374639419,
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
          "id": "47b03d309d1f5872115ac428a2d75f27150ecd8d",
          "message": "Merge pull request #926\n\nUse workspace feature",
          "timestamp": "2026-05-30T22:38:56+02:00",
          "tree_id": "f9467d6b54cbb867a8cc1e98e19e77eb46f64ee6",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/47b03d309d1f5872115ac428a2d75f27150ecd8d"
        },
        "date": 1780184748696,
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
            "value": 87381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7824\nallocs=271\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 393155,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6480\nallocs=321\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135942,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 128961,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4784\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2829820,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96981,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7568\nallocs=249\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 399605,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6160\nallocs=301\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 161312,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5472\nallocs=258\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 125112,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3010990,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 123402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5056\nallocs=213\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1680,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40450,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1392\nallocs=73\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 115252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 183213,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 65451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 185813,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12528\nallocs=387\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 192133,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15568\nallocs=483\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 119042,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116702,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 171032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 154242,
            "unit": "ns",
            "extra": "gctime=0\nmemory=17232\nallocs=506\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 356645,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24240\nallocs=743\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 297454,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 75301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4592\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74491,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4640\nallocs=149\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77522,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1440\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57660,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3664\nallocs=145\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 70131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1936\nallocs=121\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 126862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3104\nallocs=119\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 90771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5136\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 116142,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2992\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95641,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5088\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 776720,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5296\nallocs=198\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 300074,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9888\nallocs=401\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 135092,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95442,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5424\nallocs=206\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 783380,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 97232,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4896\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 307344,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8304\nallocs=302\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 134422,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95362,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4720\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 775820,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5680\nallocs=222\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 299244,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10080\nallocs=413\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4752\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781750,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96421,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5232\nallocs=194\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 299784,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9632\nallocs=385\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44510,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424\nallocs=62\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2160\nallocs=108\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 141192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3552\nallocs=203\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 134152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2368\nallocs=129\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 53140,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1808\nallocs=78\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2800\nallocs=140\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 106192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3008\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 137462,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1232\nallocs=59\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 342225,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24592\nallocs=838\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39171,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1184\nallocs=60\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40191,
            "unit": "ns",
            "extra": "gctime=0\nmemory=960\nallocs=26\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 159872,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4160\nallocs=214\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 242873,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2032\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5011061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 63471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2064\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 89672,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2656\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1310,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 198133,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2864\nallocs=166\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1492753980,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11915872823,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10383590495,
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
          "id": "4acab23195776dd93f059b6d73351a2916eeb3fb",
          "message": "Bump",
          "timestamp": "2026-06-01T11:15:27+02:00",
          "tree_id": "7aa0910069662804da4396e0ba9d78a8da7b363d",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/4acab23195776dd93f059b6d73351a2916eeb3fb"
        },
        "date": 1780310952511,
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
            "value": 87531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 284324,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3856\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 136202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5344\nallocs=250\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 130732,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=222\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2828569,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 97161,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7424\nallocs=240\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 288994,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9056\nallocs=376\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 168202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5424\nallocs=255\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 122011,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4880\nallocs=200\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3011391,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 90771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=188\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1720,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40620,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1232\nallocs=63\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 183343,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 110042,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 62360,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1312\nallocs=78\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 182132,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12368\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 197473,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15680\nallocs=490\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 119891,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 171032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156302,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16864\nallocs=483\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 355325,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23984\nallocs=729\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 298004,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 75601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4576\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5056\nallocs=175\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77811,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5440\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51371,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1488\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 58680,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3744\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 89801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1792\nallocs=112\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 92831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4320\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 89121,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5456\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 106151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2352\nallocs=131\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95481,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5152\nallocs=189\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 777531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5168\nallocs=190\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 297084,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9696\nallocs=389\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134682,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95482,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 780741,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4288\nallocs=135\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 301144,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9664\nallocs=387\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 133982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5392\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 779121,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97351,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5136\nallocs=188\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 300314,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9632\nallocs=385\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95201,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=205\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96791,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5248\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 309514,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12720\nallocs=472\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43141,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1584\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2208\nallocs=111\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 109662,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1328\nallocs=64\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 136772,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2272\nallocs=123\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52490,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2128\nallocs=98\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102021,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2528\nallocs=123\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 99182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2608\nallocs=145\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 80741,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 342015,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23792\nallocs=788\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39100,
            "unit": "ns",
            "extra": "gctime=0\nmemory=752\nallocs=33\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1040\nallocs=31\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 136322,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4096\nallocs=210\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 239984,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3792\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5019219,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 66381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=112\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 72832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=127\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1300,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 197612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2992\nallocs=174\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1499177203,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11953233850,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10369770427,
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
          "id": "f49923a4c13b06325ff32696952b34d5ec73998f",
          "message": "Merge pull request #927\n\nAdd device libs from ROCm 7.0.2 for Julia 1.13",
          "timestamp": "2026-06-03T14:45:33+02:00",
          "tree_id": "db5945992113ca859b236e90c5fafebb05ee5e99",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/f49923a4c13b06325ff32696952b34d5ec73998f"
        },
        "date": 1780504114316,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 620,
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
            "value": 86721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7248\nallocs=235\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 283534,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9120\nallocs=383\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 132701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4720\nallocs=211\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 128622,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2830679,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96522,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7264\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 398946,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=241\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 161462,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=254\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 125241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4544\nallocs=179\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3010532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 87271,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4000\nallocs=147\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1610,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 39990,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1184\nallocs=60\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 183233,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 119621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 66311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 186173,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12176\nallocs=365\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 195203,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15552\nallocs=482\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 120502,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 115651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 169593,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 155303,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16896\nallocs=485\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 355134,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23696\nallocs=711\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289534,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74191,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4272\nallocs=151\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 73501,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4752\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77031,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5296\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51380,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1392\nallocs=78\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 57211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3648\nallocs=144\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 90061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=336\nallocs=21\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 93842,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4464\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 88552,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5168\nallocs=206\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 112572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2368\nallocs=132\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 132972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 94771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4368\nallocs=140\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 774400,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 96822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4800\nallocs=167\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 298774,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9520\nallocs=378\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133662,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95181,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 784161,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96381,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4528\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 304945,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10208\nallocs=421\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 94801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4832\nallocs=169\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 772081,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 94952,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=196\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 305064,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10064\nallocs=412\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 133482,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 94961,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 782411,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 94081,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=196\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 298415,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9808\nallocs=396\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44041,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1488\nallocs=66\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75781,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2256\nallocs=114\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 169563,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2704\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 60091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=496\nallocs=12\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1792\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2816\nallocs=136\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 176962,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2880\nallocs=162\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 123882,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1584\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 339895,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24176\nallocs=812\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39110,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1072\nallocs=53\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 39650,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 147182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3344\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237883,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1840\nallocs=60\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5038970,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 64551,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2064\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 59681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1664\nallocs=88\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1290,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 122581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2880\nallocs=167\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1490559052,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11957081563,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10414604626,
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
          "id": "756602c3f51e8c00931ee025e6dbe6008a3db546",
          "message": "Merge pull request #928\n\nSetup AMD MI300 CI runners on Alps",
          "timestamp": "2026-06-12T23:17:58+02:00",
          "tree_id": "0ec330cae71de971d20006e65fce7d3dff02c62e",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/756602c3f51e8c00931ee025e6dbe6008a3db546"
        },
        "date": 1781508954603,
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
            "value": 240,
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
            "value": 86251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7728\nallocs=265\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 393845,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9120\nallocs=383\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 131681,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5344\nallocs=250\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 103022,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4704\nallocs=190\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2827930,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96412,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7280\nallocs=231\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 285244,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6240\nallocs=306\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 160812,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4816\nallocs=217\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 120772,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4512\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 3014433,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 128932,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4720\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1680,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 39371,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1424\nallocs=75\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 152432,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 88321,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1984\nallocs=120\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 181912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12352\nallocs=376\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 190933,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15472\nallocs=477\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 114451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116331,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 166203,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156173,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16928\nallocs=482\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 346025,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23856\nallocs=721\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289864,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 64761,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4496\nallocs=165\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 73791,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4976\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 76481,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5472\nallocs=175\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51540,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1168\nallocs=64\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 56210,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3648\nallocs=144\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 142162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2368\nallocs=148\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 141832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3968\nallocs=173\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 86921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=212\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 152202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=140\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 132902,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95052,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4384\nallocs=141\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 777081,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 96731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5376\nallocs=203\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 299584,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10096\nallocs=414\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133322,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 78081,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5248\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 783471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5296\nallocs=198\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 308254,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12640\nallocs=470\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132802,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 94832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5616\nallocs=218\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 774621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 96802,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5248\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 307245,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12960\nallocs=487\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 129672,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 78151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=210\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781931,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5552\nallocs=214\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 298414,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9776\nallocs=394\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44380,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1760\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 74131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2240\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 108282,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3200\nallocs=181\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 86471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1920\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 50661,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1920\nallocs=85\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 100341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2752\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 117622,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2784\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 95391,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1216\nallocs=58\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 341945,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24576\nallocs=837\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 38830,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1376\nallocs=72\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40880,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1168\nallocs=39\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 158462,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3008\nallocs=142\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 238013,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3504\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 4942659,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 43630,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1520\nallocs=79\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 128022,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2464\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1290,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 106671,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=130\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1501349912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 12041117438,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10491950084,
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
          "id": "7c9aab0ce63f66e1d4c525cc99b355ac2ef1a618",
          "message": "Merge pull request #932",
          "timestamp": "2026-06-22T14:37:32+02:00",
          "tree_id": "948b7655213c92504316bdeaf3a151eaa8fb62be",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/7c9aab0ce63f66e1d4c525cc99b355ac2ef1a618"
        },
        "date": 1782146506680,
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
            "value": 330,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 85972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 412075,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9120\nallocs=383\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 137091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4800\nallocs=216\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 130332,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5200\nallocs=221\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2810115,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 102751,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7264\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 442706,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9056\nallocs=376\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 167432,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5456\nallocs=257\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 127031,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4112\nallocs=152\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2984467,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 70231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4352\nallocs=169\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1700,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 40561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1136\nallocs=57\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 121541,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 114461,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 66551,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1408\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 181832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12608\nallocs=392\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 192932,
            "unit": "ns",
            "extra": "gctime=0\nmemory=14464\nallocs=414\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 122251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116342,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 153822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16880\nallocs=484\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 350744,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24240\nallocs=728\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 296083,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74481,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4544\nallocs=168\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74251,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5040\nallocs=174\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 76951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5504\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 52171,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1488\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 58731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3664\nallocs=145\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 85101,
            "unit": "ns",
            "extra": "gctime=0\nmemory=736\nallocs=46\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 69261,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3936\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 98642,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5168\nallocs=206\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 101231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2992\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134242,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95431,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4752\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 774349,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8432\nallocs=361\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=196\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 297464,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7392\nallocs=245\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=205\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 781800,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5808\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 299524,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7024\nallocs=222\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 133912,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95711,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5616\nallocs=218\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 775219,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8432\nallocs=361\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4272\nallocs=134\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 297424,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9696\nallocs=389\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 134602,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4512\nallocs=149\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 780269,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 97121,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5552\nallocs=214\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 299264,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9808\nallocs=396\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44550,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1472\nallocs=65\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76661,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 173202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2848\nallocs=159\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 84571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=124\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1616\nallocs=66\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102811,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=121\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 178873,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1040\nallocs=47\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 96051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2800\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 379995,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24800\nallocs=851\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39540,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1360\nallocs=71\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40350,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1456\nallocs=57\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 159152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3648\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 238933,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1856\nallocs=61\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5031334,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 65521,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1536\nallocs=80\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 72491,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=127\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1280,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 124252,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3312\nallocs=194\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1491816057,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11773992921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10954774141,
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
          "id": "a5e146f245348b1975727f18074af4ae75b13797",
          "message": "Merge pull request #937\n\nUpdate support for sparse linear algebra",
          "timestamp": "2026-06-30T15:09:44+02:00",
          "tree_id": "d6437f1e57dbb9a53a1f07e0545079dff4f860a0",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/a5e146f245348b1975727f18074af4ae75b13797"
        },
        "date": 1782831159063,
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
            "value": 330,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 84292,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7680\nallocs=262\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 293895,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9184\nallocs=384\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135722,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4608\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 132152,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5872\nallocs=263\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2807689,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 96281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7456\nallocs=242\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 287604,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6016\nallocs=292\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 167202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4592\nallocs=203\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 125922,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3968\nallocs=143\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2982122,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 92532,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4720\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1730,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 39861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=608\nallocs=24\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 183732,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 114581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2256\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 179792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12448\nallocs=382\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 194043,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15328\nallocs=468\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 120192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 115092,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 169572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 155643,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16976\nallocs=490\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 355605,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24080\nallocs=732\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 288914,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74941,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4240\nallocs=149\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74711,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4112\nallocs=116\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77611,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5024\nallocs=147\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 51731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1232\nallocs=68\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 58071,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3296\nallocs=122\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 94771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 80561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4112\nallocs=182\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 99582,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4944\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 96512,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2864\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 128472,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 93621,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4288\nallocs=135\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 773851,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 96932,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4960\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 297064,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7568\nallocs=256\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133542,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95001,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3968\nallocs=115\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 782220,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8352\nallocs=356\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96222,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5184\nallocs=191\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 298834,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9424\nallocs=372\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132642,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 94581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5248\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 774460,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8432\nallocs=361\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4448\nallocs=145\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 295865,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9552\nallocs=380\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 132902,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95071,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=193\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 780021,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8352\nallocs=356\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96352,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4992\nallocs=179\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 298845,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9760\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 44040,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1376\nallocs=59\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2272\nallocs=115\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 114072,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3296\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 72881,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2288\nallocs=124\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 49511,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=82\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2752\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 182162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3744\nallocs=216\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 95631,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2464\nallocs=136\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 399686,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25712\nallocs=908\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39220,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1248\nallocs=64\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 39911,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1184\nallocs=40\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 163522,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3712\nallocs=186\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237684,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3376\nallocs=156\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5033960,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 62991,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=112\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 68431,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2128\nallocs=117\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1300,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 125162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2784\nallocs=161\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1500471208,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 11927903571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 10964090555,
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
          "id": "eb93b5656d1aad83979849a50781546ebf3b3a85",
          "message": "Merge pull request #936\n\nAdd precompilation workload and move SpecialFunctions to an extension",
          "timestamp": "2026-06-30T15:47:15+02:00",
          "tree_id": "d1a6b30881920a86d78ef2c0e2a069798f481ff2",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/eb93b5656d1aad83979849a50781546ebf3b3a85"
        },
        "date": 1782841851483,
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
            "value": 90241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7840\nallocs=272\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 353106,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6272\nallocs=308\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135482,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=259\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 135662,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=204\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2809250,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 97172,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7712\nallocs=258\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 355145,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5776\nallocs=277\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 167612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5504\nallocs=260\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 129142,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3968\nallocs=143\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2992613,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 91361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4128\nallocs=155\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1700,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 37610,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1360\nallocs=71\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 183413,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 183752,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 129132,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3024\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 183193,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12640\nallocs=389\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 200783,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15904\nallocs=499\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 123511,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 118861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 171683,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 157563,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16880\nallocs=484\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 355115,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24112\nallocs=732\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 296484,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 77311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4608\nallocs=172\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 76601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4976\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 78741,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5104\nallocs=152\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 54210,
            "unit": "ns",
            "extra": "gctime=0\nmemory=592\nallocs=28\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 60091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3616\nallocs=142\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 93311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2368\nallocs=148\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 92652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4032\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 89721,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4944\nallocs=192\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 85791,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2464\nallocs=138\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 135552,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 96452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5152\nallocs=189\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 774731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 98962,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4848\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 298594,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7152\nallocs=230\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 135822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 94301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5264\nallocs=196\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 784232,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 97331,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4464\nallocs=146\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 298674,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7344\nallocs=242\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 130971,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 96022,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5088\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 777831,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 98311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5184\nallocs=191\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 298324,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7136\nallocs=229\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 135062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 96642,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5440\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 782452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 98122,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4960\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 301604,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7024\nallocs=222\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43351,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1744\nallocs=82\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 76341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2240\nallocs=113\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 112921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2832\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 138192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2880\nallocs=161\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 52431,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2112\nallocs=97\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2560\nallocs=125\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 179123,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2896\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 72901,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2256\nallocs=123\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 343395,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23152\nallocs=748\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39471,
            "unit": "ns",
            "extra": "gctime=0\nmemory=528\nallocs=19\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1024\nallocs=30\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 161552,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3104\nallocs=148\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 238273,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2176\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5042653,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 64121,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2096\nallocs=115\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 114951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2400\nallocs=134\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1360,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 198053,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1232\nallocs=64\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1563779825,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 36146906781,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 2133164742,
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
          "id": "9ec4f4c792b397a2f59d4c7c7e7fe7a9f633b719",
          "message": "Swap links",
          "timestamp": "2026-06-30T16:18:51+02:00",
          "tree_id": "0961b6c5cb9684ba779ae98d440c7eef77d5b0d1",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/9ec4f4c792b397a2f59d4c7c7e7fe7a9f633b719"
        },
        "date": 1782849252443,
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
            "value": 84211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 254694,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3808\nallocs=154\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 135832,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4672\nallocs=208\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 129572,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5712\nallocs=253\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2810268,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 95221,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7712\nallocs=258\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 244924,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4976\nallocs=227\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 165612,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 126121,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4832\nallocs=197\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2990730,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 92841,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3808\nallocs=135\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1800,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 36780,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1392\nallocs=73\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 114921,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 115301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 129452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1248\nallocs=74\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 181202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12192\nallocs=361\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 189583,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15760\nallocs=490\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 117271,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 115531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 170432,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156122,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16912\nallocs=486\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 346644,
            "unit": "ns",
            "extra": "gctime=0\nmemory=23952\nallocs=722\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 289124,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 73531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4144\nallocs=143\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 73221,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4864\nallocs=163\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 76811,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=176\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 53931,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1216\nallocs=67\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 56211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3696\nallocs=147\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 145212,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1232\nallocs=77\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 137382,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3824\nallocs=164\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 90591,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4384\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 154392,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1552\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 133452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 93451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4320\nallocs=137\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 775090,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 96731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4688\nallocs=160\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 295974,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7360\nallocs=243\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133742,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95331,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4976\nallocs=178\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 783300,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 96182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4496\nallocs=148\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 300034,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6960\nallocs=218\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 132982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 94691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5216\nallocs=193\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 773311,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 96821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=197\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 298234,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6432\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 130622,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95261,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4960\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781390,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96551,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4512\nallocs=149\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 295414,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6992\nallocs=220\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43271,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1728\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 74451,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2224\nallocs=112\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 167683,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3840\nallocs=221\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 141342,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2944\nallocs=165\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 49791,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2176\nallocs=101\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101541,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2864\nallocs=144\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 120091,
            "unit": "ns",
            "extra": "gctime=0\nmemory=464\nallocs=11\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 73051,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2352\nallocs=129\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 343175,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24688\nallocs=844\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39231,
            "unit": "ns",
            "extra": "gctime=0\nmemory=560\nallocs=21\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1040\nallocs=31\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 149062,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4048\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 239214,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2048\nallocs=73\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5037479,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 44811,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1440\nallocs=74\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 67701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2176\nallocs=120\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1310,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 195652,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=11\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1562645503,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 36259541503,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 2131870273,
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
          "id": "9bc35f1e796133086bbf4b7c09b8f1f4a907d351",
          "message": "Merge pull request #929\n\n- Support for WMMA instructions for RDNA4 GPUs\n- Rename WMMA -> WMMA_3 for RDNA3 GPUs (breaking)",
          "timestamp": "2026-07-01T09:12:14+02:00",
          "tree_id": "b12fcca439cc8ba97769806c71c98bac95ea63de",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/9bc35f1e796133086bbf4b7c09b8f1f4a907d351"
        },
        "date": 1782896385138,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 670,
            "unit": "ns",
            "extra": "gctime=0\nmemory=48\nallocs=3\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/blocking",
            "value": 280,
            "unit": "ns",
            "extra": "gctime=0\nmemory=16\nallocs=1\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "amdgpu/synchronization/stream/nonblocking",
            "value": 400,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 87651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8032\nallocs=284\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 290364,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5696\nallocs=272\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 136182,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 127982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4480\nallocs=176\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2812289,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 98192,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7296\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 243584,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5568\nallocs=264\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 168293,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5856\nallocs=282\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 122592,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4400\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2987552,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 147162,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5456\nallocs=238\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1720,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 39821,
            "unit": "ns",
            "extra": "gctime=0\nmemory=784\nallocs=35\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 115351,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 97151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 131032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3024\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 183372,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12752\nallocs=396\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 191073,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15712\nallocs=487\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 122112,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116541,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 171772,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 156672,
            "unit": "ns",
            "extra": "gctime=0\nmemory=17728\nallocs=537\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 355875,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24368\nallocs=743\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 303814,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 74731,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3888\nallocs=127\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 74861,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4912\nallocs=166\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 77161,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 55211,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1600\nallocs=91\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 56591,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3680\nallocs=146\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 145892,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2560\nallocs=160\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 61691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3744\nallocs=159\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 87631,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5280\nallocs=213\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 108792,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2992\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 134592,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95752,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4656\nallocs=158\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 776561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97761,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5600\nallocs=217\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 296454,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9536\nallocs=379\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 134982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 95992,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4560\nallocs=152\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 781911,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 97291,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=210\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 295774,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=215\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 134512,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95801,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5904\nallocs=236\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 775531,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8432\nallocs=361\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4160\nallocs=127\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 302224,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7200\nallocs=233\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 135202,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5232\nallocs=194\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 778971,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96941,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5440\nallocs=207\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 296404,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6976\nallocs=219\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43920,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1728\nallocs=81\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1216\nallocs=49\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 110181,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3024\nallocs=170\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 77711,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2272\nallocs=123\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 51191,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1936\nallocs=86\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 102061,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2496\nallocs=121\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 178402,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1184\nallocs=56\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 78972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2336\nallocs=128\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 342554,
            "unit": "ns",
            "extra": "gctime=0\nmemory=25120\nallocs=871\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39581,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1120\nallocs=56\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40771,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1872\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 157862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3568\nallocs=177\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 239313,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1696\nallocs=51\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5025691,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 131032,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2720\nallocs=149\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 132972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2688\nallocs=152\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1310,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 123892,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2944\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1566079357,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 36502576967,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 2134396602,
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
          "id": "4ba6e0b4ccc836c9192ea193455a0edb3494420e",
          "message": "Merge pull request #942\n\nBump actions/checkout from 6 to 7 in the all-github-actions group",
          "timestamp": "2026-07-02T08:20:39+02:00",
          "tree_id": "e178c9006a366f75189d534d2381a48494a41897",
          "url": "https://github.com/JuliaGPU/AMDGPU.jl/commit/4ba6e0b4ccc836c9192ea193455a0edb3494420e"
        },
        "date": 1782985447972,
        "tool": "julia",
        "benches": [
          {
            "name": "amdgpu/synchronization/context/device",
            "value": 620,
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
            "value": 350,
            "unit": "ns",
            "extra": "gctime=0\nmemory=32\nallocs=2\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/1d",
            "value": 86201,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7760\nallocs=267\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1",
            "value": 319185,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6032\nallocs=293\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=1L",
            "value": 134892,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4928\nallocs=224\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2",
            "value": 129962,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3664\nallocs=125\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Float32/dims=2L",
            "value": 2803440,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9648\nallocs=393\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/1d",
            "value": 97561,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7296\nallocs=232\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1",
            "value": 243253,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2576\nallocs=77\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=1L",
            "value": 166972,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4080\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2",
            "value": 126982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3696\nallocs=126\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/accumulate/Int64/dims=2L",
            "value": 2991421,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9408\nallocs=377\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/broadcast",
            "value": 91982,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3824\nallocs=136\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/construct",
            "value": 1690,
            "unit": "ns",
            "extra": "gctime=0\nmemory=384\nallocs=15\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copy",
            "value": 37151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1280\nallocs=66\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/cpu_to_gpu",
            "value": 182603,
            "unit": "ns",
            "extra": "gctime=0\nmemory=176\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_cpu",
            "value": 182843,
            "unit": "ns",
            "extra": "gctime=0\nmemory=208\nallocs=9\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/copyto!/gpu_to_gpu",
            "value": 61041,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1792\nallocs=108\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/bool",
            "value": 179112,
            "unit": "ns",
            "extra": "gctime=0\nmemory=12560\nallocs=384\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findall/int",
            "value": 187843,
            "unit": "ns",
            "extra": "gctime=0\nmemory=15536\nallocs=476\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/bool",
            "value": 119701,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findfirst/int",
            "value": 116352,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7776\nallocs=239\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/1d",
            "value": 169822,
            "unit": "ns",
            "extra": "gctime=0\nmemory=10800\nallocs=328\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/findmin/2d",
            "value": 155632,
            "unit": "ns",
            "extra": "gctime=0\nmemory=17008\nallocs=492\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/logical",
            "value": 351185,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24032\nallocs=727\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/iteration/scalar",
            "value": 292104,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2512\nallocs=93\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/2d",
            "value": 72651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4256\nallocs=150\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/3d",
            "value": 73951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4768\nallocs=157\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/permutedims/4d",
            "value": 75441,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5408\nallocs=171\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Float32",
            "value": 54361,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1568\nallocs=89\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand/Int64",
            "value": 55600,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2912\nallocs=98\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Float32",
            "value": 83711,
            "unit": "ns",
            "extra": "gctime=0\nmemory=752\nallocs=47\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/rand!/Int64",
            "value": 146362,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5488\nallocs=268\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn/Float32",
            "value": 93562,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5312\nallocs=215\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/random/randn!/Float32",
            "value": 110852,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3136\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/1d",
            "value": 133492,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1",
            "value": 95501,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4464\nallocs=146\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=1L",
            "value": 774131,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2544\nallocs=96\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2",
            "value": 97341,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5776\nallocs=228\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Float32/dims=2L",
            "value": 297434,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9888\nallocs=401\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/1d",
            "value": 133462,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1",
            "value": 94862,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=1L",
            "value": 781601,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2",
            "value": 95151,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4544\nallocs=151\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/mapreduce/Int64/dims=2L",
            "value": 298665,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6960\nallocs=218\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/1d",
            "value": 129141,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6176\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1",
            "value": 95271,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5696\nallocs=223\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=1L",
            "value": 772951,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8496\nallocs=362\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2",
            "value": 97282,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5648\nallocs=220\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Float32/dims=2L",
            "value": 306574,
            "unit": "ns",
            "extra": "gctime=0\nmemory=7936\nallocs=279\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/1d",
            "value": 133571,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5936\nallocs=180\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1",
            "value": 95052,
            "unit": "ns",
            "extra": "gctime=0\nmemory=4704\nallocs=161\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=1L",
            "value": 781570,
            "unit": "ns",
            "extra": "gctime=0\nmemory=8416\nallocs=357\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2",
            "value": 96001,
            "unit": "ns",
            "extra": "gctime=0\nmemory=5120\nallocs=187\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reductions/reduce/Int64/dims=2L",
            "value": 297294,
            "unit": "ns",
            "extra": "gctime=0\nmemory=9376\nallocs=369\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d",
            "value": 43120,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1760\nallocs=83\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL",
            "value": 75241,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1824\nallocs=87\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1dL_inplace",
            "value": 165292,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3248\nallocs=184\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/1d_inplace",
            "value": 111651,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3264\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d",
            "value": 50591,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1904\nallocs=84\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL",
            "value": 101221,
            "unit": "ns",
            "extra": "gctime=0\nmemory=2640\nallocs=130\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2dL_inplace",
            "value": 178993,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3312\nallocs=189\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/reverse/2d_inplace",
            "value": 136752,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3184\nallocs=181\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "array/sorting/1d",
            "value": 342394,
            "unit": "ns",
            "extra": "gctime=0\nmemory=24704\nallocs=845\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/reference",
            "value": 39281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1056\nallocs=52\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=1",
            "value": 40281,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1616\nallocs=67\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=2",
            "value": 144452,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3856\nallocs=195\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/byval/slices=3",
            "value": 237824,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1968\nallocs=68\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "integration/volumerhs",
            "value": 5035301,
            "unit": "ns",
            "extra": "gctime=0\nmemory=6912\nallocs=311\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing",
            "value": 58331,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1952\nallocs=106\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/indexing_checked",
            "value": 46671,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1776\nallocs=95\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/launch",
            "value": 1300,
            "unit": "ns",
            "extra": "gctime=0\nmemory=304\nallocs=7\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "kernel/rand",
            "value": 127022,
            "unit": "ns",
            "extra": "gctime=0\nmemory=3168\nallocs=185\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":5,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/import",
            "value": 1567060274,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":30,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/precompile",
            "value": 36346768726,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          },
          {
            "name": "latency/ttfp",
            "value": 2138341786,
            "unit": "ns",
            "extra": "gctime=0\nmemory=1344\nallocs=45\nparams={\"evals\":1,\"evals_set\":false,\"gcsample\":false,\"gctrial\":true,\"memory_tolerance\":0.01,\"overhead\":0,\"samples\":10000,\"seconds\":60,\"time_tolerance\":0.05}"
          }
        ]
      }
    ]
  }
}