module LoginMacros
  def login_employee(employee)
    login_as employee, scope: :employee
  end

  def login_admin(admin)
    login_as admin, scope: :admin_user
  end

  def logout
    click_link 'Sign out'
  end
end
