% Consistent renaming - Java blocks
% Jim Cordy, May 2010

% Revised July 2018 - update to match new Java 8 grammar - JRC

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

% Generic consistent renaming
include "generic-rename-consistent.txl"

