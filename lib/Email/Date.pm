package Email::Date;
# $Id: Date.pm,v 1.3 2004/09/24 00:00:48 cwest Exp $
use strict;

use vars qw[$VERSION @EXPORT];
$VERSION = sprintf "%d.%02d", split m/\./, (qw$Revision: 1.3 $)[1];
@EXPORT  = qw[find_date format_date];

use base qw[Exporter];
use Date::Parse;
use Email::Simple;
use Time::Piece;
use Time::Local;

=head1 NAME

Email::Date - Find and Format Date Headers

=head1 SYNOPSIS

  use Email::Date;
  
  my $email = join '', <>;
  my $date  = find_date($email);
  print $date->ymd;
  
  my $header = format_date($date->epoch);
  
  Email::Simple->create(
      header => [
          Date => $header,
      ],
      body => '...',
  );

=head1 DESCRIPTION

RFC 2822 defines the C<Date:> header. It declares the header a required
part of an email message. The syntax for date headers is clearly laid
out. Stil, even a perfectly planned world has storms. The truth is, many
programs get it wrong. Very wrong. Or, they don't include a C<Date:> header
at all. This often forces you to look elsewhere for the date, and hoping
to find something.

For this reason, the tedious process of looking for a valid date has been
encapsulated in this software. Further, the process of creating RFC
compliant date strings is also found in this software.

=head2 Functions

=over 4

=item find_date

  my $time_piece = find_date $email;

C<find_date> accepts an email message in any format
L<Email::Abstract|Email::Abstract> can understand. It looks through the
email message and finds a date, converting it to a
L<Time::Piece|Time::Piece> object.

=cut

sub find_date {
    my ($email) = _get_simple_object($_[0]);
    my $date = $email->header('Date')
                || _find_date_received($email->header('Recieved'))
                  || $email->header('Resent-Date');
    Time::Piece->new(str2time $date);
}

sub _get_simple_object {
    my ($email) = @_;
    return $email if UNIVERSAL::isa($email, 'Email::Simple');
    return Email::Simple->new($email) if ! ref($email);
    require Email::Abstract;
    return Email::Abstract->cast($email, 'Email::Simple');
}

sub _find_date_received {
    return unless @_;
    my $date = pop;
    $date =~ s/.+;//;
    $date;
}

=item format_date

  my $date = format_date; # now
  my $date = format_date( time - 60*60 ); # one hour ago

C<format_date> accepts an epoch value, such as the one returned by C<time>.
It returns a string representing the date and time of the input, as
specified in RFC 2822. If no input value is provided, the current value
of C<time> is used.

=cut

sub format_date {
    my $time = shift || time;
    my ($sec, $min, $hour, $mday, $mon, $year, $wday) = (localtime $time)[0..6];
    my $day   = (qw[Sun Mon Tue Wed Thu Fri Sat])[$wday];
    my $month = (qw[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec])[$mon];
    $year += 1900;
    
    my $diff  =   Time::Local::timegm(localtime $time)
                - Time::Local::timegm(gmtime    $time);
    my $direc = $diff < 0 ? '-' : '+';
       $diff  = abs $diff;
    my $tz_hr = int( $diff / 3600 );
    my $tz_mi = int( $diff / 60 - $tz_hr * 60 );
    
    sprintf "%s, %d %s %d %02d:%02d:%02d %s%02d%02d",
      $day, $mday, $month, $year, $hour, $min, $sec, $direc, $tz_hr, $tz_mi;

}

1;

__END__

=back

=head1 SEE ALSO

L<Email::Abstract>,
L<Time::Piece>,
L<Date::Parse>,
L<perl>.

=head1 AUTHOR

Casey West, <F<casey@geeknest.com>>.

=head1 COPYRIGHT

  Copyright (c) 2004 Casey West.  All rights reserved.
  This module is free software; you can redistribute it and/or modify it
  under the same terms as Perl itself.

=cut
