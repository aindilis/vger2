are([flossmole,ghTorrent],metasite).
are([emnlp_Conference,conll_Conference,lrec_Conference,cig_Conference],researchConference).

hasConferenceProceedings(emnlp_Conference,emnlp2020_ConferenceProceedings).
hasConferenceProceedings(lrec_Conference,lrec20202_ConferenceProceedings).
hasConferenceProceedings(conll_Conference,conll2020_ConferenceProceedings).
hasConferenceProceedings(cig_Conference,cig2020_ConferenceProceedings).

genls(file,resource).

fileContains('https://project.dke.maastrichtuniversity.nl/games/files/proceedings-CIG2018.pdf',cig2020_ConferenceProceedings).

