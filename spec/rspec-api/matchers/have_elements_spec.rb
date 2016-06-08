require 'spec_helper'
require 'rspec-api/matchers/attributes/have_attributes'

describe 'have_attributes matcher' do
  include RSpecApi::Matchers::Attributes
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to have_attributes(...)' do

    it 'catch .* as anonymous key and check type' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":[{".*": 121}, {".*": 321}]}'
      expect(response).to have_attributes attr
    end

    it 'ignore .* (anonymous key) and check type' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":[{"z": 122}, {"k": 321}]}'
      expect(response).to have_attributes attr
    end

    it 'verify type without anonymous key if type is array' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>{:number=> :integer}}}}}}
      response.body = '{"name":[123, 321]}'
      expect(response).to have_attributes attr
    end

    it 'verify several types without anonymous key if type is array' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>[:number, :string]}}}}}
      response.body = '{"name":["124", 321]}'
      expect(response).to have_attributes attr
    end

    it 'allow mixed types and format verify for anonymous key arrays' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>[{:number => :integer}, :string]}}}}}
      response.body = '{"name":["125", 321]}'
      expect(response).to have_attributes attr
    end

    it 'error out if type do not verify for unnamed elements' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":["126", 321]}'
      expect {
        expect(response).to have_attributes attr
      }.to fail_with %r{expected body to have attributes}
    end

    it 'error out if format do not verify for unnamed elements' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>{string: :url}}}}}}
      response.body = '{"name":["127", "321"]}'
      expect {
        expect(response).to have_attributes attr
      }.to fail_with %r{expected body to have attributes}
    end

  end
end

