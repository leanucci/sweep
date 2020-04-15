require 'spec_helper'

describe Api::BaseApp do
  context "on GET to '/'" do
    it "responds 'welcome'" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq("welcome")
    end
  end
end
