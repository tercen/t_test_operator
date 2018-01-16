# TTEST : Student's t-test

```
https://github.com/tercen/ttest_operator.git
```

```R

packrat::off()
unlink('packrat', recursive = TRUE)

devtools::install_github("tercen/TSON", ref = "1.4-rtson", subdir="rtson", upgrade_dependencies = TRUE)
devtools::install_github("tercen/teRcen", ref = "0.4.10", upgrade_dependencies = TRUE)
 
remove.packages("tercen", lib = "./packrat/lib/x86_64-pc-linux-gnu/3.3.2")
remove.packages("rtson", lib = "./packrat/lib/x86_64-pc-linux-gnu/3.3.2")
  
packrat::init(options = list(
  use.cache = TRUE
  ))
  
git add -A && git commit -m "length and not len" && git tag -a 0.0.3 -m "++" && git push && git push --tags
```

```R

packrat::status()
packrat::snapshot()

packrat::off()
packrat::on()

packrat::bundle(include.src=FALSE, overwrite = TRUE, include.bundles=FALSE)

packrat::unused_packages()
packrat::clean()
packrat::clean('tercen', force=TRUE)

```

