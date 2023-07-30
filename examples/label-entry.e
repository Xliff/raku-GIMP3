use v6.c;

use GTK::Application;
use GIMP::UI::Label::Entry;

my $a = GTK::Application.new( title => 'org.genex.gimp.label.entry' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::Label::Entry.new('Hello, ');

  $l.value-changed.tap( -> *@a {
    say "Hello, { $l.value }";
  });

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
