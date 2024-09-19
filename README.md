# ZLE (Symbolic Eigenvalue Calculation for Integer Linear Eigenvalues)


## Setup

1. Determine your base directory by running $UserBaseDirectory in the Mathematica environment
   
2. From your installation location, copy lib.wl to a place where Mathematica can find it
  - mkdir yourbasedirectory/applications/lib
  - cp lib.wl yourbasedirectory/applications/lib
    
3. Generate matrices and compute eigenvalues by running .nb scripts in your Mathematica folder!

## File Descriptions

**`fgen.nb`** generates integer-linear matrices. It takes a list of fibonacci factors ($dfac$) to produce a matrix whose dimension is the product of said factors.

**`gen.nb`** generates integer-linear matrices. It takes a partial order $X$ and constructs its corresponding $M^x$.

**`eig.nb`** computes symbolic eigenvalues for a given matrix $A$. You can import a matrix that was exported in either generation script, or of course create your own cell to do matrix creation and computation in the same place.

zle-mma offers both matrix generation and eigenvalue computation. It has the second fastest runtime next to the C++ implementation. Note that for very large general matrix creation, gen.nb currently filters permutations from an exponentially-sized sample space (instead of constructing them from ground-up, like gen.py), which may cause high memory demand.

## Citation

```bibtex
@misc{xxxx.xxxxx,
  Author = {Jonny Luntzel, Abraham Miller},
  Title = {Fast Symbolic Integer-Linear Spectra},
  Year = {2024},
  Eprint = {arXiv:xxxx.xxxxx},
}
