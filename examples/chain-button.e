use v6.c;

use GIMP::Raw::Types;

use GTK::Application;
use GIMP::RGB;
use GIMP::UI::ChainButton;

my $a = GTK::Application.new( title => 'org.genex.gimp.label.color' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $c = GIMP::UI::ChainButton.new( GIMP_CHAIN_BOTTOM );

  $*SCHEDULER.cue( every => 5, {
    CATCH { default { .message.say } }

    $c.active = $c.active.not;
    say "Active: { $c.active }";
  });

  $a.window.add($c);
  $a.window.show_all;
});

$a.run;
