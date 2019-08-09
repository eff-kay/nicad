% Blind renaming - ATL functions
% Jim Cordy, May 2010

% Using ATL grammar
include "atl.grm"

redefine rule_
	[rule_header]
	'{ [NL][IN] 
	    [rule_body] [EX]
	'} 
end redefine

define rule_header
        [rule_attribute*] 'rule [identifier] [rule_arguments?] [extends_id?] 
end define

define rule_body
	[inPattern?] 
	[using_clause?] 
	[outPattern?] 
	[actionBlock?] 
end define

define rule_attribute
	'unique | 'lazy | 'abstract | 'refining | 'entrypoint | 'endpoint | 'nodefault
end define

define rule_arguments
	'( [list parameter] ') 
end define

define potential_clone
    [rule_]
end define

% Generic blind renaming
include "generic-rename-blind.txl"

