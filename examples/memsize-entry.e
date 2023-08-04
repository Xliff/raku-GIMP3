use v6.c;

use GTK::Application;
use GIMP::UI::MemsizeEntry;

my $a = GTK::Application.new( title => 'org.genex.gimp.memory.entry' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::MemsizeEntry.new( ud => 1 );

  say "Default:      { $l.value }";
  say "Maximum size: { $l.upper }";
  say "Minimum size: { $l.lower }";

  $l.value-changed.tap( -> *@a {
    say "Memory size seleceted: { $l.value }";
  });

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
