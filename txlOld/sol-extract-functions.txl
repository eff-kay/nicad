% Example using TXL 10.5a source coordinate extensions to extract
% a table of all method definitions with source coordinates

% Jim Cordy, January 2008

% Revised July 2018 - update to match new Java 8 grammar - JRC
% Revised Nov 2012 - remove @Override annotations from clone comparison - JRC
% Revised Aug 2012 - disallow ouput forms in input parse - JRC
% Revised July 2011 - ignore BOM headers in source
% Revised 25.03.11 - match constructors as methods - JRC
% Revised 30.04.08 - unmark embedded functions - JRC

% Using Java 5 grammar
include "sol.grm"

% Ignore BOM headers from Windows
include "bom.grm"

% Redefinitions to collect source coordinates for function definitions as parsed input,
% and to allow for XML markup of function definitions as output

% Modified to match constructors as well.  Even though the grammar still
% has constructor_declaration in it, this one will match first. - JRC 25mar11


% Main function - extract and mark up function definitions from parsed input program


define method_definition
	% Input form 
	[FunctionDefinition]
end define

define program
	... | 
	[repeat FunctionDefinition] 	
end define


function main
    replace [program]
	  P [program]
	construct ab [repeat FunctionDefinition]
	  _ [^ P]
    by
      ab 
end function

rule RuleUpdateFunctions
	replace [Block]
		'{ a [Statement] '}
	by
		'{ a '}
end rule
