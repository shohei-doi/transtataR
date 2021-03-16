insheet using "data/titanic passenger list.csv"

list age sex if age > 20

reg survived c.sex age
