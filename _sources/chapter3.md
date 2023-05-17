# *nhanesmort* Stata Program Code

```Stata
qui{
	
	capture program drop nhanesmort
	program define nhanesmort
	
	syntax , [yearstart (int 4)] [yearend (int 4)]
	
	global url https://data.nber.org/mortality/
	clear
	gen deaths = .
	gen year = .
	save mortdata, replace
	
	forvalues i = `yearstart' / `yearend'{
		assert inrange(`yearstart', 1959, 2017)
		assert inrange(`yearend', 1959, 2017)
		use "${url}`i'/mort`i'", clear
		g deaths=1
		collapse (count) deaths
		gen year = `i'
	    save yr`i', replace
		use mortdata, clear
		append using yr`i'
		save mortdata, replace
		
	}
	
	use mortdata, clear
	
	gen deaths1k = deaths / 1000
	
	#delimit ;
	line deaths1k year,
	xtit("Year")
	ytit("Deaths in thousands")
	;
	#delimit cr


end

nhanesmort, yearstart(1960) yearend(1970)
	
	
	
	
}
```
