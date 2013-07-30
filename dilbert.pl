#!/usr/bin/env perl
use 5.14.2;
use warnings;

use HTML::TagParser;
use MIME::Lite;

my $html = HTML::TagParser->new('http://dilbert.com/');

my @imgs = $html->getElementsByTagName("img");

my ($i, $img, $attr, $url);


for ($i = 0; $i < 10; $i++)
{

  $img = $imgs[$i];
  $attr = $img->attributes;

  foreach my $key ( sort keys %$attr ) 
  {
     if ($key eq "src")
     {
        if ( index($attr->{$key},"dilbert.com") > 0)
        {
          $url = $attr->{$key};
        }
     }
  }
}

my $msg = MIME::Lite->new
(
  Subject => 'Daily Dilbert ',
  From    => 'FROM EMAIL',
  To      => 'TO EMAIL',
  Type    => 'text/html',
  Data    => "<img src=\"$url\">",
);

$msg->send(); 

