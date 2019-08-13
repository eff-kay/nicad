% TXL Parser and Pretty-printer for standalone Javascript code
include "sol2.grm"

define method_definition
	[srcfilename] [srclinenumber] 		% Keep track of starting file and line number
	[method_header]
	'{                                        [NL][IN] 
	    [method_contents]			  [EX]
	    [srcfilename] [srclinenumber] 	% Keep track of ending file and line number
	'}
end define

define method_header
	  'function [opt id] [ParameterList]
                     [FunctionalDefinitionInternalModifiers*]
                     [opt OptionalReturnBlock]
end define

define method_contents
	[repeat Statement]
end define

define xml_source_coordinate
    '< [SPOFF] 'source [SP] 'file=[stringlit] [SP] 'startline=[stringlit] [SP] 'endline=[stringlit] '> [SPON] [NL]
end define

define end_xml_source_coordinate
    [NL] '< [SPOFF] '/ 'source '> [SPON] [NL]
end define

redefine program
	...
    | 	[repeat FunctionDefinition]
end redefine


% Main function - extract and mark up function definitions from parsed input program
function main
    replace [program]
	P [program]
    construct Functions [repeat FunctionDefinition]
    	_ [^ P] 			% Extract all functions from program
    by 
    	Functions
end function
