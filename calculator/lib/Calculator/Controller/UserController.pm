package Calculator::Controller::UserController;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Calculator::Model::MainModel;

sub check_if_logged_in {
  my $self = shift;
  return 1 if $self->session('authenticated');
  $self->redirect_to('/');
  return 0;
}

sub check_if_authenticating {
  my $self = shift;
  return 1 if $self->session('authenticating');
  $self->redirect_to('/');
  return 0;
}

sub login_get {
  my $self = shift;

  $self->param('redirect_to')
    ? $self->session(redirect_to => $self->param('redirect_to'))
    : $self->session(redirect_to => "");

  if (!$self->session('authenticated')) {
    return $self->render('/login');
  } else {
    return $self->redirect_to('/');
  }
}

sub process_login {
  my $self = shift;
  my $redirect = $self->session('redirect_to');
  my ($username, $attempted_password) = ($self->param('username'), $self->param('password'));
  
  if (Calculator::Model::MainModel::check_for_user($username, $attempted_password) == 1) {
    $self->login(username => $self->param('username'), authenticated => 1, authenticating => 0);
    return ($redirect) ? $self->redirect_to($redirect) : $self->redirect_to("/calculator");
  } else {
    $self->flash( 'error' => 'Bad username or password.');
    return ($redirect) ? $self->redirect_to("/login?redirect_to=$redirect") : $self->redirect_to("/login");
  }
}

1;
