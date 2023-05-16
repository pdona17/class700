*** Advanced stata programming Project
*5/16/2023
*Replicate figure of US mortality from 1959-2017 from "twoway" page on website.


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
	line deaths year


end

nhanesmort, yearstart(1959) yearend(1960)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}