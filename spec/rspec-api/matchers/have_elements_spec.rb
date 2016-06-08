require 'spec_helper'
require 'rspec-api/matchers/attributes/have_attributes'

describe 'have_attributes matcher' do
  include RSpecApi::Matchers::Attributes
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to have_attributes(...)' do

    it 'catch .* numbers' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":[{".*": 123}, {".*": 321}]}'
      expect(response).to have_attributes attr
    end

    it 'ignore .* keys' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":[{"z": 123}, {"k": 321}]}'
      expect(response).to have_attributes attr
    end

    it 'do not need keys if type is array' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>:number}}}}}
      response.body = '{"name":[123, 321]}'
      expect(response).to have_attributes attr
    end

    it 'allow mixed types in unnamed elements' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>[:number, :string]}}}}}
      response.body = '{"name":["123", 321]}'
      expect(response).to have_attributes attr
    end

    it 'allow mixed types and format verify for unnamed elements' do
      attr = {:name=>{:type=>{:array=>{".*"=>{:type=>[{:number => :integer}, :string]}}}}}
      response.body = '{"name":["123", 321]}'
      expect(response).to have_attributes attr
    end

  end
end

