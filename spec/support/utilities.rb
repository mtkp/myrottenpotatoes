def login_with_omniauth
  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  visit login_path
  click_link "Log in with Twitter"
end
