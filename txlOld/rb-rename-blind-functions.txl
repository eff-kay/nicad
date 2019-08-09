% Blind renaming - Ruby functions

% Using Ruby grammar
include "ruby.grm"

redefine method_definition
	'def [singleton_dot_or_coloncolon?] [fname] [argdecl] 
	    [body_statement]
	'end
end redefine

define potential_clone
    [method_definition]
end define

% Generic blind renaming
include "generic-rename-blind.txl"

redefine xml_source_coordinate
    '< [SPOFF] 'source [SP] 'file=[stringlit] [SP] 'startline=[stringlit] [SP] 'endline=[stringlit] '> [SPON] [newline]
end redefine

redefine end_xml_source_coordinate
    [newline] '< [SPOFF] '/ 'source '> [SPON] [newline]
end redefine

