#!perl -Tw
use warnings;
use strict;
use Test::More;

BEGIN {
    plan tests => 2;
    use_ok( 'HTML::Tidy' );
}

my $input=q{Here's some <B>ed and <BR/>eakfest MarkUp};

my $expected=<<'EOD';
<!DOCTYPE 
html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
<title>
</title>
</head>
<body>
Here's some
<b>ed
and<br>
eakfest
MarkUp</b>
</body>
</html>
EOD
my @expected = split(/\n/, $expected);

my $cfg = 't/wordwrap.cfg';
my $tidy = new HTML::Tidy( {config_file => $cfg} );

my $result = $tidy->clean( $input );
my @result = split(/\n/, $result);
is_deeply( \@result, \@expected, 'Cleaned stuff looks like what we expected');

