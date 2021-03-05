#!/usr/bin/perl -I/home/phil/perl/cpan/DataTableText/lib/ -I/home/phil/perl/cpan/GitHubCrud/lib/
#-------------------------------------------------------------------------------
# Push Perl to GitHub
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use GitHub::Crud qw(:all);
use YAML::Loader;
use feature qw(say current_sub);

my $home = q(/home/phil/www/www/);                                              # Local files
my $user = q(philiprbrenan);                                                    # User
my $repo = q(uploadImageFileUsingCurlAndApache);                                # Repo

push my @files, sort                                                            # Files in play
  grep {!m(saveImage.pl)}
  searchDirectoryTreesForMatchingFiles($home);

for my $s(@files)                                                                 # Upload each selected file
 {my $t = swapFilePrefix($s, $home);
  my $w = eval {writeFileFromFileUsingSavedToken($user, $repo, $t, $s)};
  lll "$w $s $t";
 }
