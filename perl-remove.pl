#!/usr/bin/perl -w
 
use strict;
use IO::Dir;
use ExtUtils::Packlist;
use ExtUtils::Installed;
 
sub emptydir($) {
    my ($dir) = @_;
    my $dh = IO::Dir->new($dir) || return(0);
    my @count = $dh->read();
    $dh->close();
    return(@count == 2 ? 1 : 0);
}
 
# Find all the installed packages
print("Finding all installed modules...\n");
my $installed = ExtUtils::Installed->new();
 
foreach my $module (grep(!/^Perl$/, $installed->modules())) {
   my $version = $installed->version($module) || "???";
   print("Found module $module Version $version\n");
   print("Do you want to delete $module? [n] ");
   my $r = <STDIN>; chomp($r);
   if ($r && $r =~ /^y/i) {
      # Remove all the files
      foreach my $file (sort($installed->files($module))) {
         print("rm $file\n");
         unlink($file);
      }
      my $pf = $installed->packlist($module)->packlist_file();
      print("rm $pf\n");
      unlink($pf);
      foreach my $dir (sort($installed->directory_tree($module))) {
         if (emptydir($dir)) {
            print("rmdir $dir\n");
            rmdir($dir);
         }
      }
   }
}
