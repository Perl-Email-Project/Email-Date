use ExtUtils::MakeMaker;

WriteMakefile (
               AUTHOR        => 'Casey West <casey@geeknest.com>',
               ABSTRACT      => "Find and Format Date Headers",
               NAME          => 'Email::Date',
               PREREQ_PM     => {
                                 'Date::Parse' => '2.27',
                                 'Email::Simple' => '1.9',
                                 'Test::More' => '0.47',
                                 'Time::Local' => '1.07',
                                 'Time::Piece' => '1.08',
                                },
               VERSION_FROM  => 'lib/Email/Date.pm',
              );
