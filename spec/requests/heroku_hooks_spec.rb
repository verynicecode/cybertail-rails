require 'rails_helper'

describe 'Heroku hooks' do
  it 'something' do
    heroku_service = Service.create name: 'Heroku'

    params = {
      app: "app-name",
      release: "v1",
      user: "jon.allured@gmail.com"
    }

    post '/heroku_hooks', params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq heroku_service
    expect(hook.message).to eq "v1 deployed by jon.allured@gmail.com."
    expect(hook.url).to eq "https://dashboard.heroku.com/apps/app-name"
  end
end
