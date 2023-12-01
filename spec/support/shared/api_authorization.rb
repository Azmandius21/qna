shared_examples 'API Authorizable' do
  context 'unauthorized' do
    it 'returns 401 status if there is no acces_token' do
      do_request(method, api_path, headers: headers)
      expect(response.status).to eq 401
    end

    it 'returns 401 status if acces_token is invaled' do
      do_request(method, api_path, params: { acces_token: 123 }, headers: headers)
      expect(response.status).to eq 401
    end
  end
end
