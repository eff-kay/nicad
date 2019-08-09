% Blind renaming - Java functions
% Jim Cordy, May 2010

% Revised July 2018 - update to match new Java 8 grammar - JRC

% Using Java grammar
include "sol2.grm"

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
	[function_header] [NL]
	[function_body]	[NL]
end define


define potential_clone
    [FunctionDefinition]
end define

% Generic nonterminal filtering
include "generic-filter.txl"

