#!perl -Tw

use warnings;
use strict;
use Test::More tests => 3;

BEGIN {
    use_ok( 'HTML::Tidy' );
}

my $html = join '', <DATA>;

my @expected = split /\n/, q{
- (1:1) Warning: missing <!DOCTYPE> declaration
- (4:9) Warning: too many title elements in <head>
};
chomp @expected;
shift @expected; # First one's blank

my $tidy = new HTML::Tidy;
isa_ok( $tidy, 'HTML::Tidy' );
$tidy->ignore( type => TIDY_INFO );
$tidy->parse( '-', $html );

my @returned = map { $_->as_string } $tidy->messages;
s/[\r\n]+\z// for @returned;
is_deeply( \@returned, \@expected, 'Matching warnings' );

__DATA__
<HTML>
    <HEAD>
        <TITLE>Test stuff</TITLE>
        <TITLE>As if one title isn't enough</TITLE>
    </HEAD>
    <BODY BGCOLOR="white">
        <P>This is my paragraph</P>
    </BODY>
</HTML>
