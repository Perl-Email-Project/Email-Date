use strict;
use ExtUtils::MakeMaker;

WriteMakefile (
  AUTHOR        => 'Casey West <casey@geeknest.com>',
  ABSTRACT      => "Find and Format Date Headers",
  NAME          => 'Email::Date',
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl'), : ()),
  PREREQ_PM     => {
    'Date::Parse'     => '2.27',
    'Email::Abstract' => '2.10', # ->new method
    'Email::Simple'   => '1.9',
    'Test::More'      => '0.47',
    'Time::Local'     => '1.07',
    'Time::Piece'     => '1.08',
  },
  VERSION_FROM  => 'lib/Email/Date.pm',
);
