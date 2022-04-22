module LoginMacros
  def login(employee)
    visit '/'
    fill_in 'Email', with: employee.email
    fill_in 'Password', with: employee.password
    click_button 'Log in'
  end

  def login_admin(admin)
    visit '/admin'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
  end

  def logout
    click_link 'Sign out'
  end
end
