require 'rails_helper'

describe 'Heroku hooks' do
  before(:each) do
    host! "hooks.example.com"
  end

  it 'something' do
    service = Service.create name: 'Heroku'
    project = service.projects.create name: 'cybertail'

    params = {
      app: 'cybertail',
      release: 'v1',
      user: 'jon.allured@gmail.com'
    }

    post "/v1/#{project.token}", params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service_id).to eq service.id
    expect(hook.message).to eq "v1 deployed by jon.allured@gmail.com"
    expect(hook.url).to eq "https://dashboard.heroku.com/apps/cybertail"
  end
end
