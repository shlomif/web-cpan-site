#!/usr/bin/env perl

use strict;
use warnings;

use HTML::Latemp::GenMakeHelpers ();
use Path::Tiny                   qw/ path tempdir tempfile cwd /;

my $generator = HTML::Latemp::GenMakeHelpers->new(
    'hosts' => [
        {
            'id'         => "common",
            'source_dir' => "common",
            'dest_dir'   => "common",
        },
        {
            'id'         => "src",
            'source_dir' => "src",
            'dest_dir'   => "dest",
        }
    ],
);

$generator->process_all();

my $mak_fh = path("include.mak");
my $text   = $mak_fh->slurp_utf8();
$text =~ s!^(T2_DOCS = .*)humour/fortunes/fortunes-index.html!$1!m;
$mak_fh->spew_utf8($text);
