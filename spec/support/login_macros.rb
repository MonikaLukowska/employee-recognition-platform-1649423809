module LoginMacros
  def login(employee)
    visit '/'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
  end

  def logout
    click_link 'Sign out'
  end
end
