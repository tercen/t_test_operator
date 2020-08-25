library(tercen)
library(dplyr)

do.ttest = function(df, ...) {
  pv = NaN
  df <- df[order(df$.group.labels), ]
  
  grp <- unique(df$.group.colors)
  a <- df$.y[df$.group.colors == grp[1]]
  b <- df$.y[df$.group.colors == grp[2]]
  
  result = try(t.test(a, b, ...), silent = TRUE)
  print(result)
  if(!inherits(result, 'try-error')) pv = result$p.value
  return (data.frame(.ri = df$.ri[1], .ci = df$.ci[1], pv= c(pv)))
}

ctx = tercenCtx()

if (length(ctx$colors) < 1) stop("A color factor is required.")

if(as.logical(ctx$op.value('paired'))) {
  if (length(ctx$labels) < 1) stop("Labels are required for a paired test.")
}

df <- ctx %>% 
  select(.ci, .ri, .y) %>%
  mutate(.group.colors = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$colors)),
         .group.labels = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$labels))) %>%
  group_by(.ci, .ri) %>%
  do(do.ttest(., 
              alternative = ctx$op.value('alternative'),
              mu = as.double(ctx$op.value('mu')),
              paired = as.logical(ctx$op.value('paired')),
              var.equal = as.logical(ctx$op.value('var.equal')),
              conf.level = as.double(ctx$op.value('conf.level')))) %>%
  ctx$addNamespace() %>%
  ctx$save()
