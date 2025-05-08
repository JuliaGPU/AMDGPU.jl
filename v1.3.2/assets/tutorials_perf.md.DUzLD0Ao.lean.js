import{_ as h,C as e,c as k,o as r,aj as d,G as n,w as l,j as s,a as i}from"./chunks/framework.BufSHavq.js";const f=JSON.parse('{"title":"Performance Tips","description":"","frontmatter":{},"headers":[],"relativePath":"tutorials/perf.md","filePath":"tutorials/perf.md","lastUpdated":null}'),o={name:"tutorials/perf.md"};function c(E,a,g,y,u,F){const t=e("PluginTabsTab"),p=e("PluginTabs");return r(),k("div",null,[a[2]||(a[2]=d("",21)),n(p,null,{default:l(()=>[n(t,{label:"unsafe_trunc(Int, 1.0)"},{default:l(()=>a[0]||(a[0]=[s("div",{class:"language-julia vp-adaptive-theme"},[s("button",{title:"Copy Code",class:"copy"}),s("span",{class:"lang"},"julia"),s("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[s("code",null,[s("span",{class:"line"},[s("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," InteractiveUtils")]),i(`
`),s("span",{class:"line"},[s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"InteractiveUtils"),s("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"."),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"@code_llvm"),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}}," unsafe_trunc"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"(Int, "),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"1.0"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},")")])])])],-1),s("div",{class:"language- vp-adaptive-theme"},[s("button",{title:"Copy Code",class:"copy"}),s("span",{class:"lang"}),s("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[s("code",null,[s("span",{class:"line"},[s("span",null,";  @ float.jl:336 within `unsafe_trunc`")]),i(`
`),s("span",{class:"line"},[s("span",null,"define i64 @julia_unsafe_trunc_6551(double %0) #0 {")]),i(`
`),s("span",{class:"line"},[s("span",null,"top:")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %1 = fptosi double %0 to i64")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %2 = freeze i64 %1")]),i(`
`),s("span",{class:"line"},[s("span",null,"  ret i64 %2")]),i(`
`),s("span",{class:"line"},[s("span",null,"}")])])])],-1)])),_:1}),n(t,{label:"Int(1.0)"},{default:l(()=>a[1]||(a[1]=[s("div",{class:"language-julia vp-adaptive-theme"},[s("button",{title:"Copy Code",class:"copy"}),s("span",{class:"lang"},"julia"),s("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[s("code",null,[s("span",{class:"line"},[s("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," InteractiveUtils")]),i(`
`),s("span",{class:"line"},[s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"InteractiveUtils"),s("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"."),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"@code_llvm"),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}}," Int"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"("),s("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"1.0"),s("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},")")])])])],-1),s("div",{class:"language- vp-adaptive-theme"},[s("button",{title:"Copy Code",class:"copy"}),s("span",{class:"lang"}),s("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[s("code",null,[s("span",{class:"line"},[s("span",null,";  @ float.jl:908 within `Int64`")]),i(`
`),s("span",{class:"line"},[s("span",null,"define i64 @julia_Int64_6553(double %0) #0 {")]),i(`
`),s("span",{class:"line"},[s("span",null,"top:")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %gcframe10 = alloca [6 x {}*], align 16")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %gcframe10.sub = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 0")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %1 = bitcast [6 x {}*]* %gcframe10 to i8*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  call void @llvm.memset.p0i8.i64(i8* align 16 %1, i8 0, i64 48, i1 true)")]),i(`
`),s("span",{class:"line"},[s("span",null,'  %thread_ptr = call i8* asm "movq %fs:0, $0", "=r"() #12')]),i(`
`),s("span",{class:"line"},[s("span",null,"  %tls_ppgcstack = getelementptr i8, i8* %thread_ptr, i64 -8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %2 = bitcast i8* %tls_ppgcstack to {}****")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %tls_pgcstack = load {}***, {}**** %2, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,";  @ float.jl:909 within `Int64`")]),i(`
`),s("span",{class:"line"},[s("span",null,"; ┌ @ float.jl:537 within `<=`")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %3 = bitcast [6 x {}*]* %gcframe10 to i64*")]),i(`
`),s("span",{class:"line"},[s("span",null,"   store i64 16, i64* %3, align 16")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %4 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 1")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %5 = bitcast {}** %4 to {}***")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %6 = load {}**, {}*** %tls_pgcstack, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"   store {}** %6, {}*** %5, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %7 = bitcast {}*** %tls_pgcstack to {}***")]),i(`
`),s("span",{class:"line"},[s("span",null,"   store {}** %gcframe10.sub, {}*** %7, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %8 = fcmp ult double %0, 0xC3E0000000000000")]),i(`
`),s("span",{class:"line"},[s("span",null,"; └")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %9 = fcmp uge double %0, 0x43E0000000000000")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %10 = or i1 %8, %9")]),i(`
`),s("span",{class:"line"},[s("span",null,"  br i1 %10, label %L16, label %L8")]),i(`
`),s("span",{class:"line"},[s("span")]),i(`
`),s("span",{class:"line"},[s("span",null,"L8:                                               ; preds = %top")]),i(`
`),s("span",{class:"line"},[s("span",null,"; ┌ @ floatfuncs.jl:45 within `isinteger`")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │┌ @ floatfuncs.jl:153 within `trunc`")]),i(`
`),s("span",{class:"line"},[s("span",null,"; ││┌ @ floatfuncs.jl:153 within `#trunc#806`")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │││┌ @ float.jl:393 within `round`")]),i(`
`),s("span",{class:"line"},[s("span",null,"      %11 = call double @llvm.trunc.f64(double %0)")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │└└└")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │┌ @ float.jl:410 within `-`")]),i(`
`),s("span",{class:"line"},[s("span",null,"    %12 = fsub double %0, %11")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │└")]),i(`
`),s("span",{class:"line"},[s("span",null,"; │┌ @ float.jl:572 within `==` @ float.jl:534")]),i(`
`),s("span",{class:"line"},[s("span",null,"    %13 = fcmp une double %12, 0.000000e+00")]),i(`
`),s("span",{class:"line"},[s("span",null,"; └└")]),i(`
`),s("span",{class:"line"},[s("span",null,"  br i1 %13, label %L16, label %L14")]),i(`
`),s("span",{class:"line"},[s("span")]),i(`
`),s("span",{class:"line"},[s("span",null,"L14:                                              ; preds = %L8")]),i(`
`),s("span",{class:"line"},[s("span",null,";  @ float.jl:910 within `Int64`")]),i(`
`),s("span",{class:"line"},[s("span",null,"; ┌ @ float.jl:336 within `unsafe_trunc`")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %14 = fptosi double %0 to i64")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %15 = freeze i64 %14")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %16 = load {}*, {}** %4, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"   %17 = bitcast {}*** %tls_pgcstack to {}**")]),i(`
`),s("span",{class:"line"},[s("span",null,"   store {}* %16, {}** %17, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"; └")]),i(`
`),s("span",{class:"line"},[s("span",null,"  ret i64 %15")]),i(`
`),s("span",{class:"line"},[s("span")]),i(`
`),s("span",{class:"line"},[s("span",null,"L16:                                              ; preds = %L8, %top")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %18 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 2")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %19 = bitcast {}** %18 to [3 x {}*]*")]),i(`
`),s("span",{class:"line"},[s("span",null,";  @ float.jl:912 within `Int64`")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %ptls_field11 = getelementptr inbounds {}**, {}*** %tls_pgcstack, i64 2")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %20 = bitcast {}*** %ptls_field11 to i8**")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %ptls_load1213 = load i8*, i8** %20, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %box = call noalias nonnull dereferenceable(16) {}* @ijl_gc_pool_alloc(i8* %ptls_load1213, i32 752, i32 16) #9")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %21 = bitcast {}* %box to i64*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %22 = getelementptr inbounds i64, i64* %21, i64 -1")]),i(`
`),s("span",{class:"line"},[s("span",null,"  store atomic i64 140545321349376, i64* %22 unordered, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %23 = bitcast {}* %box to double*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  store double %0, double* %23, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %24 = getelementptr inbounds [6 x {}*], [6 x {}*]* %gcframe10, i64 0, i64 5")]),i(`
`),s("span",{class:"line"},[s("span",null,"  store {}* %box, {}** %24, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  call void @j_InexactError_6555([3 x {}*]* noalias nocapture noundef nonnull sret([3 x {}*]) %19, {}* inttoptr (i64 140545480066496 to {}*), {}* readonly inttoptr (i64 140545321350176 to {}*), {}* nonnull readonly %box)")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %ptls_load81415 = load i8*, i8** %20, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %box3 = call noalias nonnull dereferenceable(32) {}* @ijl_gc_pool_alloc(i8* %ptls_load81415, i32 800, i32 32) #9")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %25 = bitcast {}* %box3 to i64*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %26 = getelementptr inbounds i64, i64* %25, i64 -1")]),i(`
`),s("span",{class:"line"},[s("span",null,"  store atomic i64 140545290413424, i64* %26 unordered, align 8")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %27 = bitcast {}* %box3 to i8*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  %28 = bitcast {}** %18 to i8*")]),i(`
`),s("span",{class:"line"},[s("span",null,"  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %27, i8* noundef nonnull align 16 dereferenceable(24) %28, i64 24, i1 false)")]),i(`
`),s("span",{class:"line"},[s("span",null,"  call void @ijl_throw({}* %box3)")]),i(`
`),s("span",{class:"line"},[s("span",null,"  unreachable")]),i(`
`),s("span",{class:"line"},[s("span",null,"}")])])])],-1)])),_:1})]),_:1})])}const b=h(o,[["render",c]]);export{f as __pageData,b as default};
