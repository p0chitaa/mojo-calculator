package Calculator;
use Mojo::Base 'Mojolicious', -signatures;
use constant EXPIRES => 1209600;
use constant SECRET => 'test!'; 

# This method will run once at server start
sub startup {
  
  my $self = shift;

  $self->secrets([SECRET]);
  $self->app->sessions->cookie_name('calc_user');
  $self->app->sessions->cookie_domain('123.net');
  $self->app->sessions->default_expiration(EXPIRES);

  $self->helper(login => sub {
    my ($c, %user) = @_;
    $c->session(%user);
  });

  $self->helper(error => sub {
    my ($c, $message) = @_;
    return $c->render(text => $message);
  });

  # Load configuration from config file
  # my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets(['8d7e8478f9d3031e273417a57f0b660043f36dcc']);

  # Router
  my $r = $self->routes;
  my $authenticating = $r->under('/')->to('UserController#check_if_authenticating');
  my $logged_in = $r->under('/')->to('UserController#check_if_logged_in');

  # Normal route to controller
  $r->get('/calculator')->to('Main#calculator');
  $r->get('/login')->to('UserController#login_get');
  $r->post('/login')->to('UserController#process_login');
  $r->any('/calculate')->to('Main#calculate');
  $r->any('/history')->to('Main#get_history');
}

1;
