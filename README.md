# t-test

##### Description

The `ttest` operator performs a (pairwise) Student's t-test on the data.

##### Usage

Input projection|.
-----------|--------
`color`    | represents the groups to compare
`y-axis`   | measurement value
`labels`   | optional, represents the pairing

Input parameters|.
---|---
`alternative`   | A character string specifying the alternative hypothesis, default is "two.sided"
`paired`        | logical, indicating whether to perform pairing, default FALSE
`p.adjust.method` | multiple testing method to be used
`mu`            | A number indicating the true value of the mean (or difference in means if you are performing a two sample test), default 0.0
`var.equal`     |logical, indicating whether to treat the two variances as being equal. If `TRUE` then the pooled variance is used to estimate the variance otherwise the Welch (or Satterthwaite) approximation to the degrees of freedom is used, default `FALSE`
`conf.level`    |numeric, confidence level of the interval, default 0.95

Output relations|.
---|---
`group1`| first group of the comparison
`group2`| second group of the comparison
`n1`| group1 size
`n2`| group2 size
`statistic`| Test statistic
`df`| Degrees of freedom
`p`| p-value
`p.adj`| Adjusted p-value
`p.adj.signif`| Label displaying significance

##### Details

The operator uses the `t_test` function from the `rstatix` R package.

##### See Also

[anova](https://github.com/tercen/anova_operator)

