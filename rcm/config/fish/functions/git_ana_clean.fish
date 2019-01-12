function git_ana_clean --description "Clean configure and anaconda.spec.in after bumpver"
    git checkout -- ./configure.ac ./anaconda.spec.in
end

