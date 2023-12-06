require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers){ { "CONTENT-TYPE" => 'application/json',
                         "ACCEPT" => 'application/json' } }
  let!(:question) { create(:question) }
  let(:access_token) { create(:access_token) }
  let!(:answers) { create_list(:answer, 3, question: question) }

  describe 'GET /api/v1/questions/:id/answers' do
    let(:api_path){ "/api/v1/questions/#{question.id}/answers" }

    it_behaves_like 'API Authorizable'do
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
          expect(json).to_not  have_key(attr)
        end
      end
    end
  end

  describe 'GET /api/v1/answers/:id' do
    let!(:answer) { create(:answer, :with_attached_files) }
    let(:api_path) { "/api/v1/answers/#{answer.id}" }
    let!(:comments) { create_list(:comment, 3, commentable: answer) }
    let!(:links) { create_list(:link, 2, linkable: answer) }

      it_behaves_like 'API Authorizable'do
        let(:method) { :get }
      end

      context 'authorized' do
        let(:answer_response) { json['answer'] }

        before { get api_path, params: { access_token: access_token.token }, headers: headers }

        it 'return 200 status' do
          expect(response).to be_successful
        end

        it 'return all public attr' do
          %w[id body created_at updated_at ].each do |attr|
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
end
