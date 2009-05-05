share_examples_for 'It displays the login page' do
  it 'should display the username and password login page' do
    @response.body.should include('Login')

    @response.body.should have_tag('form', :action => url(:perform_login)) { |nodes|
      nodes.first.should have_tag('input', :name => '_method', :value => 'put')
      nodes.first.should have_tag('input', :name => 'email')
      nodes.first.should have_tag('input', :name => 'password')
      nodes.first.should have_tag('input', :type => 'submit',  :value => 'Log In')
    }
  end

  it 'should display the OpenID login page' do
    @response.body.should include('Login')

    @response.body.should have_tag('form', :action => url(:openid)) { |nodes|
      nodes.first.should have_tag('input', :name => 'postLoginTargetURI', :value => url(:openid))
      nodes.first.should have_tag('input', :name => 'openid_url')
      nodes.first.should have_tag('input', :type => 'submit', :value => 'Log In')
    }
  end
end