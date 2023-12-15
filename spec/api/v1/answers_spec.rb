require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }
  let!(:question) { create(:question) }
  let(:access_token) { create(:access_token) }
  let!(:answers) { create_list(:answer, 3, question: question) }
  let!(:me) { create(:user) }

  describe 'GET /api/v1/questions/:id/answers' do
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:answers_response) { json['answers'] }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return list of answers' do
        expect(answers_response.size).to eq 3
      end

      it 'return all public attr' do
        %w[id body author].each do |attr|
          expect(answers_response.first[attr]).to eq answers.first.send(attr).as_json
        end
      end

      it 'does not return private attr' do
        %w[qustion].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

  describe 'GET /api/v1/answers/:id' do
    let!(:answer) { create(:answer, :with_attached_files) }
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let!(:comments) { create_list(:comment, 3, commentable: answer) }
    let!(:links) { create_list(:link, 2, linkable: answer) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:answer_response) { json['answer'] }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return all public attr' do
        %w[id body created_at updated_at].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end

      it 'return all comments' do
        expect(answer_response['comments'].count).to eq comments.count
      end

      it 'return all links' do
        expect(answer_response['links'].size).to eq links.count
      end

      it 'return all files' do
        expect(answer_response['files'].size).to eq 1
      end
    end
  end

  describe 'POST api/v1/questions/:id/answers #create' do
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }
    let(:answer_attr) { attributes_for(:answer) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'authorized with valid answer attr' do
      before do
        post api_path,
             params: { answer: answer_attr, access_token: access_token.token },
             headers: headers
      end

      it 'return 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'save  answer in database' do
        expect do
          post api_path,
               params: { answer: answer_attr, access_token: access_token.token },
               headers: headers
        end.to change(Answer, :count).by(1)
      end

      it 'return all public fields after creating the answer' do
        expect(json['answer']['body']).to eq answer_attr[:body]
      end
    end

    context 'authorized with invalid answer attr' do
      let(:invalid_answer_attr) { attributes_for(:answer, :invalid) }
      before do
        post api_path,
             params: { answer: invalid_answer_attr, access_token: access_token.token },
             headers: headers
      end

      it 'return error' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not save the answer to database' do
        expect do
          post api_path,
               params: { answer: invalid_answer_attr, access_token: access_token.token },
               headers: headers
        end.to_not change(Answer, :count)
      end

      it 'should contain errors key' do
        expect(json).to have_key('errors')
      end
    end
  end

  describe 'PATCH api/v1/answers/:id #update' do
    let(:answer) { create(:answer, author: me) }
    let(:new_answer_attr) { attributes_for(:answer, body: 'NewBody') }
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :patch }
    end

    before do
      patch api_path,
            params: { answer: new_answer_attr,
                      answer_id: answer.id,
                      access_token: access_token.token },
            headers: headers
    end

    it 'return status 202' do
      expect(response).to be_accepted
    end
  end

  describe 'DELETE api/v1/answers/:id #destroy' do
    let!(:answer) { create(:answer) }
    let(:api_path) { "/api/v1/answers/#{answer.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :delete }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { answer.update(author: me) }

      context 'the answers author' do
        it 'return status 202' do
          delete api_path,
                 params: { answer_id: answer.id, access_token: access_token.token },
                 headers: headers

          expect(response).to have_http_status(:accepted)
        end

        it 'remove a answer from the database' do
          expect do
            delete api_path,
                   params: { access_token: access_token.token },
                   headers: headers
          end.to change(Answer, :count).by(-1)
        end
      end

      context 'not author of the answer' do
        let(:other_user) { create(:user) }
        let(:access_token) { create(:access_token, resource_owner_id: other_user.id) }

        it 'return status 403' do
          delete api_path,
                 params: { answer_id: answer.id, access_token: access_token.token },
                 headers: headers

          expect(response).to have_http_status(:forbidden)
        end

        it 'remove a answer from the database' do
          expect do
            delete api_path,
                   params: { access_token: access_token.token },
                   headers: headers
          end.to_not change(Answer, :count)
        end
      end
    end
  end
end
