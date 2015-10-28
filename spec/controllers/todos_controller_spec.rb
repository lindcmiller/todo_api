require 'spec_helper'

RSpec.describe TodosController, type: :controller do
  describe "GET /index" do
    let(:todo) { create(:todo) }
    it "returns a todo list" do
      todo
      get :index, format: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      let(:valid_params) { attributes_for(:todo, title: "Do laundry") }
      it "creates a todo" do
        post :create, todo: valid_params, format: :json
        expect(response).to have_http_status(:created)
        expect { post :create, todo: valid_params, format: :json}.to change{ Todo.count }.by(1)
      end
    end
    context "with invalid params" do
      let(:invalid_params) { attributes_for(:todo, title: nil) }
      it "does not create a todo" do
        post :create, todo: invalid_params, format: :json
        expect(response).to have_http_status(422)
        expect(json["title"]).to include("can't be blank")
        expect { post :create, todo: invalid_params, format: :json}.to_not change{ Todo.count }
      end
    end
  end

  describe "DELETE /destroy" do
    let(:todo) { create(:todo) }
    it "deletes a todo" do
      todo
      expect { delete :destroy, id: todo.id}.to change{ Todo.count }.by(-1)
    end
  end
end

private

def json
  JSON.parse(response.body)
end
