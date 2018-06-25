require 'rubygems'
require 'mechanize'

class UITDKHP 

  def initialize(id, pass, dsmalop)
      @a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      @home_page = @a.get('https://dkhp.uit.edu.vn/')
      @login_form = @home_page.form
      @login_form.fields[0].value = id
      @login_form.pass = pass
      @my_page = @login_form.submit
      @dkhp_form = @my_page.form
      @dkhp_form.dsmalop = dsmalop
  end

  def submit
      @a.submit(@dkhp_form, @dkhp_form.buttons[1])
  end

end


# Dang ky lop
id = '15520637'
pass = 'password'
dsmalop = 'IS254.I21'
dkhp = UITDKHP.new(id, pass, dsmalop)
while 1 do
  begin
    dkhp.submit
    sleep 1
    puts 'Start again'
  rescue StandardError => e
    puts e.message
    puts 'Thu lai...'
    dkhp = UITDKHP.new(id, pass, dsmalop)
    retry
  end
end

