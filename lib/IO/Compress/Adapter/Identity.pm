package IO::Compress::Adapter::Identity ;

use strict;
use warnings;
use bytes;

use IO::Compress::Base::Common qw(:Status);
use Compress::Raw::Zlib () ;
our ($VERSION);

$VERSION = '2.000_05';

sub mkCompObject
{
    my $crc32    = shift ;
    my $adler32  = shift ;
    my $level    = shift ;
    my $strategy = shift ;

    return bless {
                  'CompSize'   => 0,
                  'UnCompSize' => 0,
                  'Error'      => '',
                  'ErrorNo'    => 0,
                  'wantCRC32'  => $crc32,
                  'CRC32'      => Compress::Raw::Zlib::crc32(''),
                  'wantADLER32'=> $adler32,
                  'ADLER32'    => Compress::Raw::Zlib::adler32(''),                  
                 } ;     
}

sub compr
{
    my $self = shift ;

    if (defined ${ $_[0] } && length ${ $_[0] }) {
        $self->{CompSize} += length ${ $_[0] } ;
        $self->{UnCompSize} = $self->{CompSize} ;

        $self->{CRC32} = Compress::Raw::Zlib::crc32($_[0],  $self->{CRC32})
            if $self->{wantCRC32};

        $self->{ADLER32} = Compress::Raw::Zlib::adler32($_[0],  $self->{ADLER32})
            if $self->{wantADLER32};

        ${ $_[1] } .= ${ $_[0] };
    }

    return STATUS_OK ;
}

sub flush
{
    my $self = shift ;

    return STATUS_OK;    
}

sub close
{
    my $self = shift ;

    return STATUS_OK;    
}

sub reset
{
    my $self = shift ;

    $self->{CompSize}   = 0;
    $self->{UnCompSize} = 0;
    $self->{CRC32}      = Compress::Raw::Zlib::crc32('');
    $self->{ADLER32}    = Compress::Raw::Zlib::adler32('');                  

    return STATUS_OK;    
}

sub deflateParams 
{
    my $self = shift ;

    return STATUS_OK;   
}

#sub total_out
#{
#    my $self = shift ;
#    return $self->{UnCompSize} ;
#}
#
#sub total_in
#{
#    my $self = shift ;
#    return $self->{UnCompSize} ;
#}

sub compressedBytes
{
    my $self = shift ;
    return $self->{UnCompSize} ;
}

sub uncompressedBytes
{
    my $self = shift ;
    return $self->{UnCompSize} ;
}

sub crc32
{
    my $self = shift ;
    return $self->{CRC32};
}

sub adler32
{
    my $self = shift ;
    return $self->{ADLER32};
}



1;


__END__
