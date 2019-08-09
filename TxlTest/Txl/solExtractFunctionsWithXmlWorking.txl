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
include "sol2.grm"

% Ignore BOM headers from Windows
include "bom.grm"

% Redefinitions to collect source coordinates for function definitions as parsed input,
% and to allow for XML markup of function definitions as output

% Modified to match constructors as well.  Even though the grammar still
% has constructor_declaration in it, this one will match first. - JRC 25mar11


% Main function - extract and mark up function definitions from parsed input program

define function_header
	'function [opt id] [ParameterList]
             [FunctionalDefinitionInternalModifiers*]
             [opt OptionalReturnBlock] 
end define

define function_body
	[FunctionInternalEndBlock]
end define

redefine FunctionDefinition
	% Input form 
	[srcfilename] [srclinenumber] [NL]		% Keep track of starting file and line number
	[function_header]
	[function_body]	
	[srcfilename] [srclinenumber] [NL]	% Keep track of ending file and line number [NL]
	|
	
	[not token]				% disallow output form in input parse
	[opt xml_source_coordinate]
	[function_header]
	                                   [NL][IN] 
	[function_body]			  [EX]
	
	[opt end_xml_source_coordinate]

end define

define method_definition
	% Input form 
	[srcfilename] [srclinenumber] [NL]		% Keep track of starting file and line number
	[function_header]
	[function_body]	
	[srcfilename] [srclinenumber] [NL]	% Keep track of ending file and line number [NL]
end define

define program
	... | 
	[repeat method_definition] 	| [repeat FunctionDefinition] 
end define

define xml_source_coordinate
    '< [SPOFF] 'source [SP] 'file=[stringlit] [SP] 'startline=[stringlit] [SP] 'endline=[stringlit] '> [SPON] [NL]
end define

define end_xml_source_coordinate
    [NL] '< [SPOFF] '/ 'source '> [SPON] [NL]
end define


function main
    replace [program]
	  P [program]
	construct ab [repeat FunctionDefinition]
	  _ [^ P] 
    by
      ab [convertFunctionDefinitions]
end function

rule RuleUpdateFunctions
	replace [Block]
		'{ a [Statement] '}
	by
		'{ a '}
end rule


rule convertFunctionDefinitions
    % Find each function definition and match its input source coordinates
    replace [FunctionDefinition]
	FileName [srcfilename] LineNumber [srclinenumber]
	FunctionHeader [function_header]
	FunctionBody [function_body]
	EndFileName [srcfilename] EndLineNumber [srclinenumber]

    % Convert file name and line numbers to strings for XML
    construct FileNameString [stringlit]
	_ [quote FileName] 
    construct LineNumberString [stringlit]
	_ [quote LineNumber] 
    construct EndLineNumberString [stringlit]
	_ [quote EndLineNumber] 

    % Output is XML form with attributes indicating input source coordinates
    construct XmlHeader [xml_source_coordinate]
	<source file=FileNameString startline=LineNumberString endline=EndLineNumberString>
    by
    XmlHeader
	FunctionHeader 
	FunctionBody
	</source>
end rule

