package Calculator;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup {
  
  my $self = shift;
  
  # Load configuration from config file
  # my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets(['8d7e8478f9d3031e273417a57f0b660043f36dcc']);

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Main#calculator');
  $r->any('/calculate')->to('Main#calculate');
  $r->any('/history')->to('Main#get_history');
}

1;
