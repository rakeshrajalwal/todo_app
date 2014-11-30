class TodosController < ApplicationController
  def index
  @todo_items = Todo.all 
  @new_todo = Todo.new
  @person 
  end

  def delete
   params[:todos_checkbox].each do |check|
       todo_id = check
       t = Todo.find_by_id(todo_id)
       t.delete
       end 
  redirect_to :action => 'index'
  end

  def add
   todo = Todo.create(:todo_item => params[:todo][:todo_item])
     if !todo.valid?
        flash[:error] = todo.errors.full_messages.join("<br>").html_safe
   end
    if todo.valid?
        flash[:success] = "Todo added successfully"   
   end
 
   redirect_to :action => 'index'
  end

 def complete
    params[:todos_checkbox].each do |check|
       todo_id = check
       t = Todo.find_by_id(todo_id)
       t.update_attribute(:completed, true)
     end
    redirect_to :action => 'index'
 end

def upload
  uploaded_io = params[:picture]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
redirect_to :action => 'index'
end

end
