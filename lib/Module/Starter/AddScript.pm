package Module::Starter::AddScript;

use warnings;
use strict;
use Carp;
use base 'Module::Starter::App';
use Set::Object 'set';
use IO::Prompter;
use File::Spec::Functions qw/catfile/;
use Template;

use version; our $VERSION = qv('0.0.3');

sub _check_if_module_dir {

    my $items = set
      (qw/t lib README Changes MANIFEST/);
    my $present = set( glob "*" );

    my $diff = $items - $present;

    return !@$diff && 1;

}

my $skeleton;
{

    my @skeleton = <DATA>;

    s/^!=([a-z0-9]+)\b/=$1/ for @skeleton;
    $skeleton = join "", @skeleton;

}

sub run {

    my $self = shift;

    if ( not -w "./" ) {
        croak "Cannot write to Cwd - go elsewhere to create the script or fix this.";
    }

    my $dest_dir = "./";

    if ( _check_if_module_dir ) {

        if ( ! -d "bin" ) {
            mkdir "bin" or confess "Failed mkdir bin: $!";
        }

        $dest_dir = "bin";

    }

    my %config = $self->_config_read;
    $config{year} ||= (localtime(time))[5] + 1900;

    $config{script} = $ARGV[0] || prompt "Script name:";
    $config{author} ||= prompt "Author:";
    $config{email} ||= prompt "Email:";

    my $dest_filepath = catfile( $dest_dir, $config{script} );

    my $template = Template->new({ INCLUDE_PATH => "./" });
    $template->process( \$skeleton, \%config, $dest_filepath )
      || confess $template->error();

}

sub _process_command_line {} # skip super's processing of commandline

1; # Magic true value required at end of module

=encoding utf8

=head1 NAME

Module::Starter::AddScript - Create a perl script, understands Module::Starter dir structure

=head1 VERSION

This document describes Module::Starter::AddScript version 0.0.1


=head1 SYNOPSIS

    use Module::Starter::AddScript;

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.


=head1 DESCRIPTION

=for author to fill in:
    Write a full description of the module and its features here.
    Use subsections (=head2, =head3) as appropriate.


=head1 INTERFACE

=for author to fill in:
    Write a separate section listing the public components of the modules
    interface. These normally consist of either subroutines that may be
    exported, or methods that may be called on objects belonging to the
    classes provided by the module.

=head2 run

does the work

=head1 DIAGNOSTICS

=for author to fill in:
    List every single error and warning message that the module can
    generate (even the ones that will "never happen"), with a full
    explanation of each problem, one or more likely causes, and any
    suggested remedies.

=over

=item C<< Error message here, perhaps with %s placeholders >>

[Description of error here]

=item C<< Another error message here >>

[Description of error here]

[Et cetera, et cetera]

=back


=head1 CONFIGURATION AND ENVIRONMENT

=for author to fill in:
    A full explanation of any configuration system(s) used by the
    module, including the names and locations of any configuration
    files, and the meaning of any environment variables or properties
    that can be set. These descriptions must also include details of any
    configuration language used.

Module::Starter::AddScript requires no configuration files or environment variables.


=head1 DEPENDENCIES

=for author to fill in:
    A list of all the other modules that this module relies upon,
    including any restrictions on versions, and an indication whether
    the module is part of the standard Perl distribution, part of the
    module's distribution, or must be installed separately. ]

None.


=head1 INCOMPATIBILITIES

=for author to fill in:
    A list of any modules that this module cannot be used in conjunction
    with. This may be due to name conflicts in the interface, or
    competition for system or program resources, or due to internal
    limitations of Perl (for example, many modules that use source code
    filters are mutually incompatible).

None reported.


=head1 BUGS AND LIMITATIONS

=for author to fill in:
    A list of known problems with the module, together with some
    indication Whether they are likely to be fixed in an upcoming
    release. Also a list of restrictions on the features the module
    does provide: data types that cannot be handled, performance issues
    and the circumstances in which they may arise, practical
    limitations on the size of data sets, special cases that are not
    (yet) handled, etc.

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-addscript@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Torbjørn Lindahl  C<< <torbjorn.lindahl@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, Torbjørn Lindahl C<< <torbjorn.lindahl@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

=cut
__DATA__
#!perl

use strict;
use warnings;
use utf8;
use Carp;

use Getopt::Euclid;

[% FOR m IN project_modules -%]
use [% m %];
[% END -%]

!=encoding utf8

!=head1 NAME

[% script %] - Your program here

!=head1 VERSION

This documentation refers to [% script %] version 0.1

!=head1 USAGE

    [% script %] [options]  -s[ize]=<h>x<w>  -o[ut][file] <file>

!=head1 REQUIRED ARGUMENTS

!=over

!=item  -s[ize]=<h>x<w>

Specify size of simulation

!=for Euclid:
    h.type:    int > 0
    h.default: 24
    w.type:    int >= 10
    w.default: 80

!=item  -o[ut][file] <file>

Specify output file

!=for Euclid:
    file.type:    writable
    file.default: '-'

!=back

!=head1 OPTIONS

!=over

!=item  -i

Specify interactive simulation

!=item  -l[[en][gth]] <l>

Length of simulation. The default is l.default

!=for Euclid:
    l.type:    int > 0
    l.default: 99

!=item --debug [<log_level>]

Set the log level. Default is log_level.default but if you provide --debug,
then it is log_level.opt_default.

!=for Euclid:
    log_level.type:        int
    log_level.default:     0
    log_level.opt_default: 1

!=item --version

!=item --usage

!=item --help

!=item --man

Print the usual program information

!=back

Remainder of documentation starts here...

!=head1 AUTHOR

[% author %] ([% email %])

!=head1 BUGS

There are undoubtedly serious bugs lurking somewhere in this code.
Bug reports and other feedback are most welcome.

!=head1 COPYRIGHT

Copyright (c) [% year %], [% author %]. All Rights Reserved.
This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html)

!=cut
