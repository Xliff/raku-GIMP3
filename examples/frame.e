use v6.c;

use GTK::Application;
use GIMP::UI::Button;
use GIMP::UI::Frame;

my $a = GTK::Application.new( title => 'org.genex.gimp.frame' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::Frame.new('Button Frame');
  my $b = GIMP::UI::Button.new;

  $b.label = 'Button';
  $l.margins = 20;
  $l.add($b);

  $b.clicked.tap( -> *@a {
    say "The button was clicked!"
  });

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
