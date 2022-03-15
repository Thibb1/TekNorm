#!/usr/bin/env perl
# TekNorm_v0.0.1
# Author: Thibb1
# Last update: 15/03/2022

use strict;
use warnings;
no warnings qw(experimental::vlb);
use Term::ANSIColor qw(:constants);
use Getopt::Long;

$Term::ANSIColor::AUTORESET = 1;

my $update = 1;
my $banned = 1;
my $comments = 0;

GetOptions(
    'update|u:i' => \$update,
    'banned|b:i' => \$banned,
    'comments|c' => \$comments,
);

sub ExitError {
    exit print STDERR BOLD RED "Error: ", WHITE shift . "\n";
}

sub line {
    my $content = shift;
    my $char_idx = shift;
    my $idx = 0;
    foreach (split /\n/, $content) {
        $idx++;
        $char_idx -= length($_) + 1;
        last unless $char_idx > 0;
    }
    return $idx;
}

system("curl -fsSL https://raw.githubusercontent.com/Thibb1/TekNorm/main/install.sh | sh") if $update;

ExitError "git is not installed" unless (`which git`);
ExitError "current directory is not a git repository" unless (`git rev-parse --is-inside-work-tree 2>/dev/null`);

my @folders = `find . -type d -not -path '*/\.*' -not -path '.'`;
@folders = map { s/^\.\///; $_ } @folders;

my @files = @ARGV;
@files = `git ls-files -o -c --exclude-standard` unless @files;

chomp @files;
chomp @folders;

@files = grep { -e -f $_ } @files;

sub G1 {
    return unless shift !~ /^\/\*\n\*\* EPITECH PROJECT, \d{4}\n\*\* .*\n\*\* File description:\n(\*\* .*\n)+\*\/\n.*/;
    print BOLD RED "[".shift."] ", WHITE "Missing or corrupted header";
    print " (G1)\n";
}

sub G1Makefile {
    return unless shift !~ /^##\n## EPITECH PROJECT, \d{4}\n## .*\n## File description:\n(## .*\n)+##\n.*/;
    print BOLD RED "[".shift."] ", WHITE "Missing or corrupted header";
    print " (G1)\n";
}

sub G2 {
    my $c = shift;
    my $file = shift;
    return unless my @m = $c =~ /^\}(?:\s*\n){3,}/gm;
    foreach (@m) {
        print BOLD RED "[$file:".(line($c, (index $c, $_))+2)."] ",
        WHITE "Separation of functions (".((() = $_ =~ /\n/g)-1)." > 1)";
        print " (F4)\n";
    }
}

sub G3 {
    return unless shift =~ /^#(?!(ifndef|endif))/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Indentation of preprocessor directives";
    print " (G3)\n";
}

sub G4 {
    return unless shift =~ /^(?!const|typedef)\w[^\n\(]+;/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Global variables";
    print " (G4)\n";
}

sub G6 {
    return unless shift =~ /^#include <(?!.*\.h)[^>]*>/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Include directive";
    print " (G6)\n";
}

sub G7 {
    return unless shift =~ /\r/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Line endings";
    print " (G7)\n";
}

sub G8 {
    return unless shift =~ /[\t ]+$/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Trailing whitespaces";
    print " (G8)\n";
}

sub G9 {
    my $c = shift;
    my $file = shift;
    return unless my @m = $c =~ /^\}\n\n$|^\{\n\s*\n|^\{\n(?:(?!\}).+\n)*\s*\n(?:(?!\}).+\n)*\s*\n/gm;
    foreach (@m) {
        print BOLD GREEN "[$file:".(line($c,(index $c, $_)+length))."] ",
        WHITE "Leading/trailing lines";
        print " (G9)\n";
    }
}

sub O3 {
    my $nb_func = () = shift =~ /^\{/gm;
    return unless $nb_func > 5;
    print BOLD RED "[".shift."] ", WHITE "Too many functions ($nb_func > 5)";
    print " (O3)\n";
}

foreach (@folders) {
    next unless $_ !~ /^(.*\/)*[a-z]+(_[a-z]+)*$/;
    print BOLD RED "[$_] ", WHITE "Directory name is not respecting snake_case";
    print " (O4)\n";
}

sub O4 {
    my $file = shift;
    return unless $file !~ /^(.*\/)*[a-z]+(_[a-z]+)*\.[ch]$/;
    print BOLD RED "[$file] ", WHITE "File name is not respecting snake_case";
    print " (O4)\n";
}

sub F2 {
    return unless shift =~ /^(?!((\w+ )+[a-z]+(_[a-z\d]+)+\()|(\w+ )+[a-z]{2,}(_[a-z]+)*\()(\w+ )+\w+\(/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Naming functions";
    print " (F2)\n";
}

sub F3 {
    my $len = length shift;
    return unless $len > 80;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Too many columns ($len > 80)";
    print " (F3)\n";
}

sub F4 {
    my $c = shift;
    my $file = shift;
    return unless my @m = $c =~ /^\{(?:(?!\}).*\n){22,}\}$/gm;
    foreach (@m) {
        print BOLD RED "[$file:".line($c, (index $c, $_))."] ",
        WHITE "Too many lines in a function (".((() = $_ =~ /\n/g)-1)." > 20)";
        print " (F4)\n";
    }
}

sub F5 {
    return unless shift =~ /^(\w+ )+\w+\((\s*\)|(.*,){4,})/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Function arguments";
    print " (F5)\n";
}

sub F6 {
    return unless shift =~ /.\/[\/*]/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Comments inside a function";
    print " (F6)\n";
}

sub F7 {
    return unless shift =~ /^ +(\w+ )+\w+\([^\)]*\).+\{/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Nested functions";
    print " (F7)\n";
}

sub L1 {
    return unless shift =~ /
        ^(?!.*for)(.+;){2,}|
        [^\s]+.*\ return|
        ^.+=.*\([^\)]*\)\s*,|
        ^(?!.*for\ ).+=[^\({]+,/x;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Code line content";
    print " (L1)\n";
}

sub L2 {
    return unless shift =~ /^( {4})*+ /;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Indentation";
    print " (L2)\n";
}

sub L3 {
    return unless shift =~ /
        \ return[^\s;]|
        \s+;$|
        [^\s]+\ {2,}|
        ,[^\s]|
        (?:,|\ (?:if|else|for|while|switch))\(|
        \)\{|
        ^(?!.*(?:return|if|else|else\ if|for|while|switch|\#define)).*\w+\ +\(|
        for\ \((\ |[^;]*;([^\s;]|\s+;|[^;]*;(\s+\)|[^\s)])))|
        [^\s](?<![-+=<>*\/(])[-+?=\/](?![-+>]|.*\.h>)|
        (?<![-+(])[-+=?:\/](?![-+>=\/\*]|.*\.h>)[^\s]|[^\s]:(?!\n)
        /x;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Spaces";
    print " (L3) '$_'\n";
}

sub L4 {
    return unless shift =~ /(if|else).*\}|^(\w+ )+\w+\(.*\{|^\ +{/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Curly brackets";
    print " (L4)\n";
}

sub L5 {
    return unless shift =~ /^(?>\s*\w+\s*){2,},/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Variable declaration";
    print " (L5)\n";
}

sub L6 {
    my $c = shift;
    my $file = shift;
    return unless my @m = $c =~ /^(?>(?:\ +\w+ [^(=;]+(?:=[^;]+;|;)\n+)+)+(?:(?!\}).*\n)+\n/gm;
    foreach (@m) {
        print BOLD GREEN "[$file:".line($c, (index $c, $_)+length)."] ",
        WHITE "Line jumps";
        print " (L6)\n";
    }
}

sub V1 {
    return unless shift =~ /^typedef(?!.*_t;|.* \{)|^\} (?!.*_t;)|^#define [^\s]*[^A-Z_ ]|^const(?! (\w+ )+[A-Z_]+ =)/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Naming identifiers";
    print " (V1)\n";
}

sub V3 {
    return unless shift =~ /\w\*/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Pointers";
    print " (V3)\n";
}

sub C1 {
    return unless shift =~ /(if|else).{2,}\ if|^\ {12,}(?:if|else|for|while)/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE " Conditional branching";
    print " (C1)\n";
}

sub C1a {
    my $c = shift;
    my $file = shift;
    return unless my @m = $c =~ /
        ^\ {4}+else\ if(?:.*{\n[^\}]*|(?:.*\n){2}).*else\ if
    /xgm;
    foreach (@m) {
        print BOLD GREEN "[$file:".line($c, (index $c, $_)+length)."] ",
        WHITE "Nested conditional branching";
        print " (C1)\n";
    }
}

sub C2 {
    return unless shift =~ /\?.+(\?|[^ \()]\()/;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Ternary";
    print " (C2)\n";
}

sub C3 {
    return unless shift =~ /^ *goto /;
    print BOLD GREEN "[".shift.":".shift."] ", WHITE "Goto";
    print " (C3)\n";
}

sub A3 {
    # Line break at the end of file
    my $c = shift;
    my $file = shift;
    return unless $c =~ /^(?!.*\n)\s*/gm;
    print BOLD GREEN "[$file:".line($c, length($c))."] ", WHITE "Line break at the end of file";
    print " (A3)\n";
}

sub B {
    return unless shift =~ /(?<!my_[\w]{0,4})(printf|scanf|memcpy|memset|memmove|strcat|strchar|strcpy|atoi|strlen|strstr|strncat|strncpy|strncasestr|strcmp|strncmp|strtok|strnlen|strdup|realloc)\(/;
    print BOLD RED "[".shift.":".shift."] ", WHITE "Banned function $1";
    print " (-b to ignore)\n";
}

sub CFile {
    my $file = shift;
    my $content = `cat $file`;
    my $idx = 0;
    O3 $content, $file;
    O4 $file;
    foreach (split /\n/, $content) {
        $idx++;
        F3 $_, $file, $idx;
    }
    F4 $content, $file;
    G1 $content, $file;
    G2 $content, $file;
    G9 $content, $file;
    L6 $content, $file;
    C1a $content, $file;
    A3 $content, $file;
    $content =~ s/"(.*?)"/""/gm;
    $content =~ s/'(.*?)'/''/gm;
    $content =~ s/^(\/\*|\*\*|\*\/).*//gm;
    $idx = 0;
    foreach (split /\n/, $content) {
        $idx++;
        G4 $_, $file, $idx;
        G6 $_, $file, $idx;
        G7 $_, $file, $idx;
        G8 $_, $file, $idx;
        F2 $_, $file, $idx;
        F5 $_, $file, $idx;
        F6 $_, $file, $idx;
        F7 $_, $file, $idx;
        L1 $_, $file, $idx;
        L2 $_, $file, $idx;
        L3 $_, $file, $idx;
        L4 $_, $file, $idx;
        L5 $_, $file, $idx;
        V1 $_, $file, $idx;
        V3 $_, $file, $idx;
        C1 $_, $file, $idx;
        C2 $_, $file, $idx;
        B $_, $file, $idx if $banned;
    }
}

sub HFile {
    my $file = shift;
    my $content = `cat $file`;
    my $idx = 0;
    O4 $file;
    foreach (split /\n/, $content) {
        $idx++;
        F3 $_, $file, $idx;
    }
    G1 $content, $file;
    A3 $content, $file;
    $content =~ s/"(.*?)"/""/gm;
    $content =~ s/'(.*?)'/''/gm;
    $content =~ s/^(\/\*|\*\*|\*\/).*//gm;
    $idx = 0;
    foreach (split /\n/, $content) {
        $idx++;
        G3 $_, $file, $idx;
        G4 $_, $file, $idx;
        G6 $_, $file, $idx;
        G7 $_, $file, $idx;
        G8 $_, $file, $idx;
        G9 $_, $file, $idx;
        F2 $_, $file, $idx;
        F5 $_, $file, $idx;
        F6 $_, $file, $idx if $comments;
        F7 $_, $file, $idx;
        L1 $_, $file, $idx;
        L2 $_, $file, $idx;
        L3 $_, $file, $idx;
        L4 $_, $file, $idx;
        L5 $_, $file, $idx;
        V1 $_, $file, $idx;
        V3 $_, $file, $idx;
        C2 $_, $file, $idx;
        C3 $_, $file, $idx;
    }
}

sub MkFile {
    my $file = shift;
    my $content = `cat $file`;
    my $idx = 0;
    G1Makefile $content, $file;
    A3 $content, $file;
    foreach (split /\n/, $content) {
        $idx++;
        F3 $_, $file, $idx;
    }
}

foreach my $file (grep { !/\.gitignore$|(?i:readme)\.md$/ } @files) {
    if ($file =~ /^(.*\/)*[^.]+\.c$/) {
        CFile $file;
    } elsif ($file =~ /^(.*\/)*[^.]+\.h$/) {
        HFile $file;
    } elsif ($file =~ /Makefile$/) {
        MkFile $file;
    } else {
        print BOLD RED "[$file] ", WHITE "Is probably a forbidden file.";
        print " (O1)\n";
    }
}

