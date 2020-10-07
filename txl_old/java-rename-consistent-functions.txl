% NiCad consistent renaming - Java functions
% Jim Cordy, May 2010

% Rev 19.5.20 JRC - Added blind renaming for numeric and string literals
% Rev July 2018 JRC - Updated to match new Java 8 grammar 

% NiCad tag grammar
include "nicad.grm"

% Using Java grammar
include "java.grm"

define method_definition
    [method_header]
    '{                     [NL][IN] 
	[method_contents]  [EX] 
    '}
end define

define method_header
    [repeat modifier] [opt generic_parameter] [opt type_specifier] [method_declarator] [opt throws] 
end define

define method_contents
	[repeat declaration_or_statement]     
	[opt expression_statement_no_semi]
end define

define potential_clone
    [method_definition]
end define

% Generic consistent renaming
include "generic-rename-consistent.rul"

% Literal renaming for Java
include "java-rename-literals.rul"
