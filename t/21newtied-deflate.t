BEGIN {
    if ($ENV{PERL_CORE}) {
	chdir 't' if -d 't';
	@INC = ("../lib", "lib");
    }
}

use lib 't';
use strict;
local ($^W) = 1; #use warnings;

use IO::Compress::Deflate   qw($DeflateError) ;
use IO::Uncompress::Inflate qw($InflateError) ;

sub identify
{
    'IO::Compress::Deflate';
}

require "newtied.pl" ;
run();
