:- consult('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/util.pl').
:- consult('/var/lib/myfrdcsa/codebases/minor/cyclone/frdcsa/sys/flp/autoload/kbs.pl').

:- consult('/var/lib/myfrdcsa/codebases/minor/vger2/vger2_interface.pl').

:- consult('/var/lib/myfrdcsa/codebases/minor/vger2/vger2_data.pl').

:- dynamic should/1, isa/2, repositoryContains/2.

mtConfigurationOption(baseKB,inferTypesFromArgumentTypes).

arg1Isa(acquired/2,agent).
arg2Isa(acquired/2,resource).

arg1Isa(fileContains/2,file).
arg2Isa(fileContains/2,resource).

acquired(System,SoftwareSystem) :-
	isa(SoftwareSystem,softwareSystem),
	fileContains(File,SoftwareSystem),
	isa(File,file),
	acquired(System,File).

hasSoftwareHavingCapability(System,Capability) :-
	isa(Capability,capability),
	hasCapability(SoftwareSystem,Capability),
	acquired(System,SoftwareSystem),!.

%% if we assert that we want to have a particular piece of software,
%% then attempt to download it
poss(should(download(SoftwareSystem))) :-
	(   isa(SoftwareSystem,softwareSystem),
	    not(acquired(frdcsaProject,SoftwareSystem)),
	    (	desires(andrewDougherty,package(X)),
		X = SoftwareSystem ;
		member(SoftwareSystem,X))) ;
	(   desires(andrewDougherty,hasSoftwareHavingCapability(frdcsaProject,Capability)),
	    hasCapability(SoftwareSystem,Capability),
	    acquired(frdcsaProject,SoftwareSystem)) ;
	(   should(package(ToPackageList)),
	    member(SoftwareSystem,ToPackageList)).

%% desire to package all contents of metasites
desires(andrewDougherty,package(SoftwareSystem)) :-
	isa(Metasite,metasite),
	refersTo(Metasite,SoftwareSystem),
	isa(SoftwareSystem,softwareSystem).

%% if we haven't download some piece software, try to acquire it
poss(should(tryToAcquire(SoftwareSystem))) :-
	should(download(SoftwareSystem)),
	not(acquired(SoftwareSystem)).


%% COLLECT SYSTEM METADATA

%% acquire all conference proceedings
poss(should(download(ConferenceProceedings))) :-
	isa(ResearchConference,researchConference),
	hasConferenceProceedings(ResearchConference,ConferenceProceedings),
	isa(ConferenceProceedings,conferenceProceedings),
	fileContains(File,Conferenceproceedings),
	not(acquired(frdcsaProject,ConferenceProceedingsFile)).

%% crawl all academic websites
poss(crawl(Website)) :-
	isa(University,university),
	hasUniversityWebsite(University,Website).

%% store research papers and extract system names and urls from them
poss(should(move(PaperFile,digilibResearchPaperStorageArchiveIncomingPaperDir))) :-
	isa(ResearchPaper,researchPaper),
	fileContains(PaperFile,ResearchPaper),
	not(repositoryContains(digilibResearchPaperStorageArchive,PaperFile)).

%% poss(should(processIncomingResearchPapersWithDigilib)) :-
%% 	directory_not_empty(digilibResearchPaperStorageArchiveIncomingPaperDir).

poss(extractSoftwareSystemNamesAndURLs(PaperFile,SystemNamesAndURLs)) :-
	repositoryContains(digilibResearchPaperStorageArchive,PaperFile).

desires(andrewDougherty,knowMoreAbout(andrewDougherty,Topic)) :-
	isa(Topic,topic).

%% %% "so here's the deal.  if we save a paper, move the paper into %%
%% digilib storage.  if it already exists there, skip.  if something
%% with the same name but different characteristics exists there,
%% create a duplicate with document(1).pdf of whatnot

%% get sentinel to work

%% poss(should(move(PaperFile,DigilibIncomingPaperDir))) :-
%% 	acquired(System,PaperFile),
%% 	fileContains(PaperFile,Paper),
%% 	isa(Paper,researchPaper).	

%% if a paper is moved into digilib storage, convert to text, add to
%% book-analysis system, extract urls and system names, retrieve and
%% store in our waybackmachine knockoff the contents of the websites,
%% and run radar-web-search just on those urls",

%% "if we assert that we desire to know more about a topic, launch
%% various searches, such as definitional question answering, google,
%% etc.",

%% should(runCapabilityOn(Capability,Topic)) :-

%% 	member(Capability,[definitionalQuestionAnswering,googleWebSearch]),
%% 	hasCapability(Program,Capability),

%% should(runProgramOn(Program,Topic)) :-
%% 	hasCapability(Program,definitionalQuestionAnswering),
	
	

%%    "if we assert that we desire to read a particular document, try to
%%    ensure that it already has been located or figure out to get it.
%%    also have M-x academician-start-reading locate those documents we
%%    possess and open them up for reading.",


%%    "if we assert that we desire to collaborate with someone, be sure
%%    to use audience to suggest writing them.  use research interests
%%    that they have expressed as a topic of communication",

%% poss(tell(frdcsaAgentFn(audience),andrewDougherty,should(tell(andrewDougherty,Person,Message)))) :-
%% 	desiresToCollaborateWith(andrewDougherty,Person),
%% 	findall(Topic,hasInterest(Person,Topic),Topics),
%% 	generateMessageAboutFor(Topics,Person).

%%    "if we assert that we have read a particular page of a document,
%%    process the page of the document with our reading flux processor so
%%    the computer knows that I know that which I have read.",




%%    "if we assert that we have read a particular document, if it is
%%    servicable, include a link to it from our FRDCSA dynamic page."

%%    "if we assert that we have followed a citation from a particular
%%    document to another one, do ?",

%%    "if we assert that a user has a particular academic research
%%    interest, route news to that user through audience that pertains to
%%    their interest that has been read with news-monitor",

%%    "if we assert that something is a software-system, attempt to add
%%    an entry for it into the CSO, and locate all information about it,
%%    such as what its license(s) is/are, how much it costs, where we can
%%    get it, what it's download url is if available, and start to make a
%%    package or a package generator (like the google-earth package) for
%%    it.",

%%    "if we assert that we require the definition of something, run
%%    definitional QA and other entity location and lookup services.",

%%    # add more rules for other cases

%%    "if we desire to have a given piece of software or, software having
%%    a capability, then add that software and/or capability into the
%%    vger/system-iterator priority queues.  track versions as well.  see
%%    about integration with the 'cia' software tool that tells you which
%%    software is available.",

%%    "if we get a research paper, download all of it's citations if
%%    possible and use to look for related resources (terminology,
%%    software, links).",



%%    "when we download an OVA, convert it to the appropriate VM format
%%    and load in one of systems in an airgapped capacity, if deemed
%%    trustworthy, but have backup security plans even if deemed
%%    trustworthy",

%%    "when looking for tools to package, look at productive conferences
%%    like LREC, analyze proceedings for links, etc",

%%    "when we see a pdf without a corresponding .txt conversion, convert
%%    it and save the file.",

%%    "When we find out the name of a good paper or book that we can't
%%    access, be sure to download papers that cite it.",

%%    "when we find a good system on github, look at the other systems
%%    that are hosted by its author",

%%    "When we want a particular capabiility to be developed, classify
%%    which categories that capability belongs to, and search for open
%%    source systems implementing that capability, then grab their
%%    authors and solicit their assistance in developing such a thing.",


%% # Try my hand at SKSI,

%% # ("#$thereExists" var-I2
%% #  ("#$and"
%% #   ("#$isa" var-I2 "#$Person")
%% #   ("#$desires" var-I2
%% #    ("#$possessiveRelation" var-I2 var-SOFTWARE9))))


%% ## Add new rules


%% # from /var/lib/myfrdcsa/codebases/internal/architect/requirements-tracability/notes
%% my $architectrules =
%%   [
%%    "Given a document, extract  requirements, i.e. states that are expected
%%    to hold about a particular software or greater system.",

%%    "Given a  set of  requirements, record which  have been  satisfied, and
%%    links to sets of changes that implement those.",

%%    "All changes  should be recorded  as a dag.  Determining  which changes
%%    affect others is difficult.",

%%    "This is  also the notion behind backwatcher.   Backwatcher can trouble
%%    shoot installations by manipulating changes.",

%%    "Knowing how  to add and  remove configuration options is  critical.  A
%%    simple method would  be to just use subversion.   That has the benefit
%%    that certain systems can be restored.",

%%    "Do an  analysis to determine  whether these requirements exist  in the
%%    capabilities database.",

%%    "Therefore need to extract capabilities.",

%%    "Since for most projects we have limited capability information,
%%    have to figure out some way to obtain that.",

%%    "For which system are capabilities important.",
%%   ];



%%   start writing agent rules to add goals to our system to contact
%%   potential contributors and potential funders etc







%%%%%%%%%%%%% misc


%% should(tryToAcquire(SoftwareSystem)) :-
%% 	setof(Capability,hasCapability(SoftwareSystem,Capability),Capabilities),
%% 	member(Capability,Capabilities),
%% 	not(acquired(SoftwareSystem)).

%% ("desires" "andrewDougherty" ("have-software" "andrewDougherty" "Automata Linguist"))
%% desires(andrewDougherty,haveSoftware(andrewDougherty,Software))

%% ("desires" "andrewDougherty" ("have-software-having-capability" "decision support"))
%% desires(andrewDougherty,done(hasSoftwareHavingCapability(frdcsaProject,decisionSupport),e1)).




%% look for authors homepages, maybe using "<name> site:<domain name of email address>"




%% whenever you see a conference page with a list of capabilities that
%% the A.I. should probably have, add to research-ontology.






%%    "if we assert that we desire to have software having a capability,
%%    run radar-web-search -n 300 or such on it, and download the results
%%    and package them",

%% For radar-web-search, maybe drop in Mojolicious' UA, or Selenium,
%% or some of the newer wrappers for doing web browsing from Perl, now
%% I'm forgetting what they're called.  But they looked to be working
%% well.

%% radar-web-search seems to need to be updated in regards to the
%% DuckDuckGo wrapper (it's not advancing past the first page).

%% poss(emacsCommand(['run-in-shell',['concat','"radar-web-search -n 300 "',['shell-quote-argument',Gloss]]],Result)) :-
%% 	desires(andrewDougherty,haveCapability(Capability)),
%% 	hasEnglishGloss(Capability,Gloss).

%% poss(emacsCommand(['run-in-shell',['concat','"radar-web-search -n 300 "',['shell-quote-argument',Gloss]]],Result)) :-
%% 	desires(andrewDougherty,haveCapability(Capability)),
%% 	hasEnglishGloss(Capability,Gloss).

%% poss(emacsCommand(['run-in-shell',['concat','"radar-web-search -n 300 "',['shell-quote-argument',Capability]]],Result)) :-
%% 	should(tryToAcquire(SoftwareSystem)),
%% 	findall(Capability,hasCapability(SoftwareSystem,Capability),Capabilities),
%% 	member(Capability,Capabilities).

%% %% periodically rerun the radar-web-search downloads on previously searched for items (every 2 years)
%% poss(emacsCommand(['run-in-shell',['concat','"radar-web-search -n 300 "',['shell-quote-argument',Capability]]],Result)) :-
%% 	directory_files('/var/lib/myfrdcsa/codebases/minor/software-finder/data/searches',Files),
%% 	member(File,Files),
%% 	File \= '.',
%% 	File \= '..',
%% 	atom_string(File,String),
%% 	split_string(String, "-", "", Words),
%% 	atomic_list_concat(Words,' ',Capability).


%% %% hasEnglishGloss(String,Gloss) :-
%% %% 	split_string(String, "-", "", Words),
%% %% 	atomic_list_concat(Words,' ',Gloss).

%% %% create an agenda here
   
%% %% prompt the user for authorization
