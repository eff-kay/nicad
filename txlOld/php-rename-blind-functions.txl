% Blind renaming - PHP functions

% Using PHP grammar
include "php.grm"

define method_definition
	[function_header]
	'{                                        [NL][IN] 
		[repeat TopStatement]     [EX]
	'}
end define

define function_header
	'function [opt '&] [opt id] '( [Param,] ')         [NL]
end define

define potential_clone
    [method_definition]
end define

% Generic blind renaming
include "generic-rename-blind.txl"
