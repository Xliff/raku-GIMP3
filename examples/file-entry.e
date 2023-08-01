use v6.c;

use GTK::Application;
use GIMP::UI::FileEntry;

my $a = GTK::Application.new( title => 'org.genex.gimp.file.entry' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::FileEntry.new;

  $l.filename-changed.tap( -> *@a {
    say "You chose...wisely: { $l.filename }"
  });

  $a.window.add($l);
  $a.window.show_all;
});

$a.run;
