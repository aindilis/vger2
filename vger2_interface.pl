:- set_prolog_stack(global, limit(40 000 000 000)).
:- set_prolog_stack(trail,  limit(8 000 000 000)).
:- set_prolog_stack(local,  limit(8 000 000 000)).

:- use_module(library(csv)).

:-
	csv_read_file('/var/lib/myfrdcsa/repositories/git/world-universities-csv/world-universities.csv', Rows, [functor(worldUniversity), arity(3)]),
	maplist(assert, Rows).

isa(University,university) :-
	worldUniversity(_,University,_).

hasUniversityWebsite(University,Website) :-
	worldUniversity(_,University,Website).
