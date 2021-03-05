#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Save an uploaded image file
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2021
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use CGI;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use feature qw(say current_sub);

$CGI::POST_MAX = 1024 * 1024 * 10;                                              # Maximum upload size
my $q = CGI->new();                                                             # CGI

say "Content-type: text/html\n";                                                # Standard header

if (my $i = $q->upload('image'))                                                # Get a file handle for the named file
 {my $d = ''; my $b;
  $d .= $b while $i->read($b, 1024*1024);                                       # Read file
  my $t = time;
  overWriteBinaryFile("zzz_$t.png", $d);                                        # Save file
}

=pod
#!/bin/bash
# sudo apt-get install scrot
scrot -q 100 zzz.png
curl -F 'image=@zzz.png' http://aaa.com/saveImage.pl
=cut
