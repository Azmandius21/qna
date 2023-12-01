require 'rails_helper'

describe 'Question API', type: :request do
  let(:headers){ { "CONTENT-TYPE" => 'application/json',
                         "ACCEPT" => 'application/json' } }
  let(:question) { create(:question, :with_attached_fields) }

  describe 'GET /api/v1/questions/:id' do
    let(:api_path){ "/api/v1/questions/#{question.id}" }

    it_behaves_like 'API Authorizable'do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question_response) { json['question']}
      let(:comments) { create_list(:comment, 2, commentable: question) }
      let(:links) { create_list( :link, 3)}

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'return 200 status' do
        expect(response).to be_successful
      end



      # it 'return short title' do
      #   expect(question_response['short_body']).to eq question.body.truncate(7)
      # end

      # describe 'answers' do
      #   let(:answer) { answers.first}
      #   let(:answer_response) { question_response['answers'].first }

      #   it 'return list of answers' do
      #     expect(question_response['answers'].size).to eq 3
      #   end

      #   it 'return all answers public fields' do
      #     %w[id body author_id question_id created_at updated_at].each do |attr|
      #       expect(answer_response[attr]).to eq answer.send(attr).as_json
      #     end
      #   end
      # end
    end
  end
end
