require 'rails_helper'

def create_todo()
  visit root_path
  fill_in 'todo_title', with: "Destroy the flower"
  page.execute_script("$('form#new_todo').submit();")
end

feature 'Manage todos on the list', :js => true do
  scenario 'We can add a new task' do
    create_todo()
    expect(page).to have_content("Destroy the flower")
  end
  scenario 'todo count change' do
    create_todo()
    sleep 0.3
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

end

feature 'Manage tasks', :js => true do
  scenario 'counts change on check box' do
    create_todo()
    check('todo-1')
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end
  scenario 'makes 3 tasks, finishes 2, and tallies' do
    create_todo()
    create_todo()
    create_todo()
    check('todo-1')
    check('todo-2')
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end
  scenario 'makes 3 tasks, finishes 2, and cleanups' do
    create_todo()
    create_todo()
    create_todo()
    check('todo-1')
    check('todo-2')
    click_link 'clean-up'
    sleep 0.3
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end
end
