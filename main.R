library(tercen)
library(tercenApi)
library(dplyr)
library(rstatix)

ctx = tercenCtx()

if(length(ctx$colors) < 1) stop("A color factor is required.")

paired <- ctx$op.value('paired', as.logical, FALSE)
alternative <- ctx$op.value('alternative', as.character, 'two.sided')
mu <- ctx$op.value('mu', as.double, 0.0)
var.equal <- ctx$op.value('var.equal', as.logical, TRUE)
conf.level <- ctx$op.value('conf.level', as.double, 0.95)
p.adjust.method <- ctx$op.value('conf.level', as.character, 'holm')

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
    conf.level = conf.level)) %>%
  ctx$addNamespace() %>%
  ctx$save()
