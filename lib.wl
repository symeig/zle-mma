(* ::Package:: *)

BeginPackage["lib`"];

alphabet;
addbasen;
rd0;
rd;
rd2;
genvars;
makemap;
pof;
difone;
hasdifzero;
sdc2;
fzero;
genlistsDP;
rebuildlists;
genlists;
isrt;
testevs;

initialize;
getcoeffs;
mapdlv;
dlistv2;
symeig;
testevs;

Begin["`Private`"];

alphabet[basei_]:=Table[IntegerString[i,basei],{i,0,basei-1}]
addbasen[hex1_,hex2_,bn_]:=Module[{dec1,dec2,decSum},dec1=FromDigits[hex1,bn];dec2=FromDigits[hex2,bn];
decSum=dec1+dec2;
IntegerString[decSum,bn]]
rd0[x_]:=N[Round[x,10^{-3}][[1]]]
(*rd[x_]:=RealDigits[Round[x,10^{-3}],10,dim][[;;,1]][[1]]*)
rd2[x_]:=NumberForm[x,3]
genvars[n_]:=Array[Symbol["s"<>ToString[#-1]]&,n]
makemap[listOfLists_]:=Module[{n,symbolicVars,association},n=Length[listOfLists];
symbolicVars=genvars[n];AssociationThread[listOfLists->symbolicVars]]
pof[xs_List]:=(po=Flatten[Table[{Table[{iio,iio+jjo},{iio,Total[xs[[;;aao-1]]]+1,Total[xs[[;;aao]]]-2},{jjo,2,Min[Total[xs[[;;aao]]]-iio,3]}],Table[{Total[xs[[;;aao]]]-kko,jjo},{kko,0,1},{jjo,Total[xs[[;;aao]]]+1,Total[xs[[;;aao]]]+2}]},{aao,Length[xs]-1}]];
po=Flatten[Join[po,Table[{iio,iio+jjo},{iio,Total[xs[[;;Length[xs]-1]]]+1,Total[xs[[;;Length[xs]]]]-2},{jjo,2,Min[Total[xs[[;;Length[xs]]]]-iio,3]}]]])
difone[list1_,list2_]:=Module[{result},hasdifone[x_]:=AnyTrue[list2,Abs[x-#]==1&];
hasdifzero[x_]:=AnyTrue[list2,Abs[x-#]==0&];{Select[list1,hasdifone],Select[list1,hasdifzero]}]
sdc2[xl_List,yl_List]:=(xind=fzero[xl]; yind=fzero[yl]; difs=difone[xind,yind]; out=xl; out[[Flatten[difs]]]=1;out[[Complement[yind, difs[[2]]]]]=0;out)
fzero[list_]:=Module[{indices},indices=Flatten[Position[list,0]];indices]
genlistsDP[k_]:=Module[{dp,i},dp={{1,0}};For[i=1,i<=k,i++,dp=Append[dp,{dp[[-1,1]]+dp[[-1,2]],dp[[-1,1]]}]];dp]
rebuildlists[dp_,k_]:=Module[{lists={{1},{0}},newLists,i},For[i=2,i<=k,i++,newLists=Flatten[{If[Last[#]==0,Nothing,Append[#,0]]&/@lists,Append[#,1]&/@lists},1];
lists=newLists];lists]
genlists[k_]:=Module[{dpTable,lists},dpTable=genlistsDP[k];
lists=rebuildlists[dpTable,k];lists]
isrt[yl_List]:=Insert[yl,{1},Table[{iio},{iio,2,Length[yl]}]];

initialize[batch_, base_, dim_]:=Module[{a,b,c,d,e},(a=2*base+batch;
b=Floor[base/2] -1;
c=Table[N[base^{i},a][[1]],{i,-Floor[batch/2],Ceiling[batch/2]-1}];
d = N[b*Total[c],a];
e=Table[N[i + i^{-1}+i^{-Floor[batch/2]},a][[1]],{i,1,dim}][[RandomSample[Range[dim]]]];
{a,b,c,d,e})]
getcoeffs[dim_,batch_,rvals_List,expvs_List,asn_,mp_,mpv_,A_List,base_]:=Module[{feesh,expmpi,valsub, evals,ressub, (*Ac,*)An},(*Ac=A;*)
For[loopi=Floor[dim / batch -.01],loopi>=0,loopi--,expmpi={};feesh={};
valsub = rvals;
valsub[[batch*loopi+1;;Min[dim,batch*(loopi+1)]]] += expvs[[1;;Min[batch,dim-(batch*loopi)]]]*I;
expmp=AssociationThread[Values[asn],valsub]; 
An=A /.expmp;
evals=Eigenvalues[(A /.expmp)]+mp*I;evals = SortBy[evals,Reals];
ressub=mapdlv[Map[Im,evals],1,batch, base]-mpv; 
feesh=AppendTo[feesh,ressub]];
If[batch < dim,feesh={Table[Flatten[feesh[[;;,i]]],{i,dim}][[;;,(batch-Mod[dim,  batch]+1);;]]}];
{feesh,expmpi}]
mapdlv[x_List,b_,c_,base_]:=dlistv2/@({#,b,c,base}&/@x)
(*apply dlistv2 to each imaginary number. (needs base)*)
dlistv2[x_]:=Module[{a,b,c,base},{a,b,c,base}=x;val=RealDigits[a,base][[1]][[b;;c]]]
symeig[asn_, coeffs_]:= (*Total /@( *)Reverse[#*Reverse[Values[asn]]]& /@ coeffs[[1]]
(*list of imaginary parts, start index (1), batchsize last index (12)*)
testevs[evs_List, asn_,dim_,A_List]:=Module[{vmap,symev,numout,numeric,symbolic},(For[ii=1,ii<=3,ii++,
vmap=AssociationThread[Values[asn],RandomVariate[NormalDistribution[0,1],dim]];
numout=Sort[Eigenvalues[A /. vmap]];
symev=evs/.vmap;
numeric=Map[rd0,numout];
symbolic=Map[rd0,Sort[Table[Total[i],{i,symev}]]];
Print[DeleteDuplicates[numeric-symbolic]]];
Print[])]

End[];

EndPackage[];
