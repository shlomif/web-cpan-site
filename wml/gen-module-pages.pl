#!/usr/bin/perl

use strict;
use warnings;

use lib "./lib";

use MyModulesList ();

my $modules = MyModulesList::get_module_list();

foreach my $m (@$modules)
{
    my $name      = $m->{'perl_name'};
    my $dir_name  = "src/modules/$name";
    my $file_name = "$dir_name/index.html.wml";
    my $subject   = ( $m->{'subject'} || $m->{'perl_name'} );

    if ( !-d $dir_name )
    {
        mkdir($dir_name);

        # system("svn", "add", "-N", $dir_name);
    }

    open my $out_fh, ">", $file_name;
    print {$out_fh} <<"EOF";
#include "../template.wml"

<gen_module_html "$name" />
<subject "$subject" />
EOF
    close($out_fh);

    # system("svn","add",$file_name);
    system( "git", "add", $file_name, );

    # Update the template.wml so the navigation menus will be rebuilt.
    #
    my $t = time();
    utime( $t, $t, "template.wml", );
}
