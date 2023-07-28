use v6.c;

use GIMP::Raw::Types;
use GTK::Application;
use GIMP::UI::PageSelector;

my $a = GTK::Application.new( title => 'org.genex.gimp.pageselect' );

$a.activate.tap(-> *@a {
  CATCH {
    default { .message.say; .backtrace.concise.say; }
  }

  my $l = GIMP::UI::PageSelector.new( 1...10 );
  $a.window.add($l);
  $a.window.show_all;

  # cw: Removes the last box containing Layer/Image dropdown box
  # my @boxes = $l.get_children( :internal, :widget );
  # @boxes[2].visible = False;

});

$a.run;
