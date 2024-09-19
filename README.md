# ZLE (Symbolic Eigenvalue Calculation for Integer Linear Eigenvalues)


## Setup

1. Determine your base directory by running $UserBaseDirectory in the Mathematica environment
   
2. From your installation location, copy lib.wl to a place where Mathematica can find it
  - mkdir yourbasedirectory/applications/lib
  - cp lib.wl yourbasedirectory/applications/lib
    
3. Generate matrices and compute eigenvalues by running .nb scripts in your Mathematica folder!

zle-mma offers both matrix generation and eigenvalue computation. It has the second fastest runtime next to the C++ implementation, but:
for very large general matrix creation (gen.nb), you may need to use zlepy because currently gen.nb filters legal permutations from the set of all possible permutations (instead of constructing them from ground-up), which is exponential with respect to the number of elements being permuted. 

## Citation

```bibtex
@misc{xxxx.xxxxx,
  Author = {Jonny Luntzel, Abraham Miller},
  Title = {Fast Symbolic Integer-Linear Spectra},
  Year = {2024},
  Eprint = {arXiv:xxxx.xxxxx},
}
