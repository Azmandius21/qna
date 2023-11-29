require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers){ { "CONTENT-TYPE" => 'application/json',
                         "ACCEPT" => 'application/json' } }

  describe 'GET /api/v1/questions' do
    context 'unauthorized' do
      it 'returns 401 status if there is no acces_token' do
        get '/api/v1/questions', headers: headers
        expect(response.status).to eq 401
      end

      it 'returns 401 status if acces_token is invaled' do
        get '/api/v1/questions', params: { acces_token: 123 }, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let!(:question) { questions.first}
      let(:question_response) { json.first}
      let!(:answers) { create_list(:answer, 3, question: question) }

      before { get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end

      it 'return list of questions' do
        expect(json.size).to eq 2
      end

      it 'return all public fields' do
        %w[id title body author_id created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      describe 'answers' do
        let(:answer) { answers.first}
        let(:answer_response) { question_response['answers'].first }

        it 'return list of answers' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'return all answers public fields' do
          %w[id body author_id question_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end
end
