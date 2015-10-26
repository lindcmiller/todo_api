class TodosController < ApplicationController
  before_action :set_todo, only: [:edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    render json: Todo.all
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo, status: 201
    else
      render json: @todo.errors, status: 422
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])
   if @todo.update_attributes(todo_params)
     render json: @todo, status: :ok
   else
     render json: @todo.errors, status: 422
   end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render json: nil, status: :ok
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :is_completed)
    end
end
