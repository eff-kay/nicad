% NiCad blind renaming - Java blocks
% Jim Cordy, May 2010

% Rev 19.5.20 JRC - Added blind renaming for numeric and string literals
% Rev July 2018 JRC - Updated to match new Java 8 grammar 

% NiCad tag grammar
include "nicad.grm"

% Using Java grammar
include "java.grm"

redefine block
    { [IN] [NL]
        [repeat declaration_or_statement]
	[opt expression_statement_no_semi] [EX]
    } [NL]
end redefine

define potential_clone
    [block]
end define

% Generic blind renaming
include "generic-rename-blind.rul"

% Literal renaming for Java
include "java-rename-literals.rul"
