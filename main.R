library(tercen)
library(dplyr)
 
do.ttest = function(df, ...){
  pv = NaN
  result = try(t.test(.y ~ .group.colors, data=df, ...), silent = TRUE)
  if(!inherits(result, 'try-error')) pv = result$p.value
  return (data.frame(.ri = df$.ri[1], .ci = df$.ci[1], pv= c(pv)))
}
  
ctx = tercenCtx()
 
if (length(ctx$colors) < 1) stop("A color factor is required.")
 
ctx %>% 
  select(.ci, .ri, .y) %>%
  mutate(.group.colors = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$colors))) %>%
  group_by(.ci, .ri) %>%
  do(do.ttest(., 
              alternative = ctx$op.value('alternative'),
              mu = as.double(ctx$op.value('mu')), 
              var.equal = as.logical(ctx$op.value('var.equal')),
              conf.level = as.double(ctx$op.value('conf.level')))) %>%
  ctx$addNamespace() %>%
  ctx$save()
