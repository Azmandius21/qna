require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }
    let(:access_token) { create(:access_token) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      let!(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, question: question) }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'return all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it 'return short title' do
        expect(question_response['short_body']).to eq question.body.truncate(7)
      end

      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it 'return list of answers' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'return all answers public fields' do
          %w[id body created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET /api/v1/questions/:id' do
    let!(:me) { create(:user) }
    let!(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }
    let!(:question) { create(:question, :with_attached_files, author: me) }
    let!(:comments) { create_list(:comment, 2, commentable: question) }
    let!(:links) { create_list(:link, 3, linkable: question) }
    let(:question_response) { json['question'] }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      before do
        get api_path,
            params: { question_id: question.id, access_token: access_token.token },
            headers: headers
      end

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return questions comments' do
        expect(question_response['comments'].count).to eq comments.count
      end

      it 'return links to attached files' do
        expect(question_response['files'].count).to eq 1
      end

      it 'return questions links' do
        expect(question_response['links'].count).to eq links.count
      end

      it 'return all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end
    end
  end

  describe 'POST api/v1/questions #create' do
    let(:api_path) { '/api/v1/questions' }
    let!(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }
    let(:question_attr) { attributes_for(:question) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :post }
    end

    context 'authorized with valid question attr' do
      before do
        post api_path,
             params: { question: question_attr, access_token: access_token.token },
             headers: headers
      end

      it 'return 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'save  question in database' do
        expect do
          post api_path,
               params: { question: question_attr, access_token: access_token.token },
               headers: headers
        end.to change(Question, :count).by(1)
      end

      it 'return all public fields after creating the question' do
        %w[title body].each do |attr|
          expect(json['question'][attr]).to eq question_attr[attr.to_sym]
        end
      end
    end

    context 'authorized with invalid question attr' do
      let(:invalid_question_attr) { attributes_for(:question, :invalid) }
      before do
        post api_path,
             params: { question: invalid_question_attr, access_token: access_token.token },
             headers: headers
      end

      it 'return error' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not save the question to database' do
        expect do
          post api_path,
               params: { question: invalid_question_attr, access_token: access_token.token },
               headers: headers
        end.to_not change(Question, :count)
      end

      it 'should contain errors key' do
        expect(json).to have_key('errors')
      end
    end
  end

  describe 'PATCH api/v1/questions/:id #update' do
    let(:me) { create(:user) }
    let(:question) { create(:question, author: me) }
    let(:new_question_attr) { attributes_for(:question, title: 'NewTitle', body: 'NewBody') }
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :patch }
    end

    before do
      patch api_path,
            params: { question: new_question_attr,
                      question_id: question.id,
                      access_token: access_token.token },
            headers: headers
    end

    it 'return status 202' do
      expect(response).to be_accepted
    end
  end

  describe 'DELETE api/v1/questions/:id #destroy' do
    let!(:question) { create(:question) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :delete }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { question.update(author: me) }

      context 'the questions author' do
        it 'return status 202' do
          delete api_path,
                 params: { question_id: question.id, access_token: access_token.token },
                 headers: headers

          expect(response).to have_http_status(:accepted)
        end

        it 'remove a question from the database' do
          expect do
            delete api_path,
                   params: { access_token: access_token.token },
                   headers: headers
          end.to change(Question, :count).by(-1)
        end
      end

      context 'not author of the question' do
        let(:other_user) { create(:user) }
        let(:access_token) { create(:access_token, resource_owner_id: other_user.id) }

        it 'return status 403' do
          delete api_path,
                 params: { question_id: question.id, access_token: access_token.token },
                 headers: headers

          expect(response).to have_http_status(:forbidden)
        end

        it 'remove a question from the database' do
          expect do
            delete api_path,
                   params: { access_token: access_token.token },
                   headers: headers
          end.to_not change(Question, :count)
        end
      end
    end
  end
end
