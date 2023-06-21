suppressPackageStartupMessages({
  library(tercen)
  library(tercenApi)
  library(dplyr)
  library(rstatix)
})

ctx = tercenCtx()

if(length(ctx$colors) < 1) stop("A color factor is required.")

paired <- ctx$op.value('paired', as.logical, FALSE)
alternative <- ctx$op.value('alternative', as.character, 'two.sided')
mu <- ctx$op.value('mu', as.double, 0.0)
var.equal <- ctx$op.value('var.equal', as.logical, FALSE)
conf.level <- ctx$op.value('conf.level', as.double, 0.95)
p.adjust.method <- ctx$op.value('p.adjust.method', as.character, 'holm')
detailed <- ctx$op.value('detailed', as.logical, FALSE)
reference_index <- ctx$op.value('reference_index', as.double, 1)

if(paired & length(ctx$labels) < 1) {
  stop("Labels are required for a paired test.")
} 

df <- ctx %>% 
  select(.ci, .ri, .y) %>%
  mutate(.group.colors = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$colors)),
         .group.labels = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$labels))) %>%
  arrange(.group.labels) %>%
  group_by(.ci, .ri) %>%
  do(t_test(
    ., 
    .y ~ .group.colors,
    p.adjust.method = p.adjust.method,
    alternative = alternative,
    mu = mu,
    paired = paired,
    var.equal = var.equal,
    detailed = detailed,
    ref.group = levels(.group.colors)[reference_index],
    conf.level = conf.level)) %>%
  select(-.y.) %>%
  mutate(
    n1 = as.double(n1),
    n2 = as.double(n2),
    neglog10_p = -log10(p)
  ) %>%
  rename(any_of(c(delta = "estimate"))) %>%
  ctx$addNamespace() %>%
  ctx$save()
