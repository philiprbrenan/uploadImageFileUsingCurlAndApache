#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Save an uploaded image file
# Philip R Brenan at appaapps dot com, Appa Apps Ltd Inc., 2021
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use CGI;
use Data::Dump qw(dump);
use Data::Table::Text qw(overWriteBinaryFile);
use feature qw(say current_sub);

my $debug = 0;                                                                  # Debug upload
$CGI::POST_MAX = 1024 * 1024 * 100;                                             # Maximum upload size - Gigabit Internet connection
my $q = CGI->new();                                                             # CGI

say "Content-type: text/html\n";                                                # Standard header

say STDERR dump($q, $q->multi_param) if $debug;                                 # Confirm parameters received in Apache log
if (my $i = $q->upload('image'))                                                # Get a file handle for the named file
 {my $d = ''; my $b;                                                            # Data buffe
  $d .= $b while $i->read($b, 1024*1024);                                       # Read file
  my $t = time;                                                                 # Time
  overWriteBinaryFile("zzz_$t.png", $d);                                        # Save file in a unique file
 }

=pod
#!/bin/bash
# sudo apt-get install scrot                                                    # Install screen shotter
scrot -q 75 zzz.png                                                             # Take a screenshot
curl -F 'image=@zzz.png' http://aaa.com/saveImage.pl                            # Upload the screen shot under name image
=cut
