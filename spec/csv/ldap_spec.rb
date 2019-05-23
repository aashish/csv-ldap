
require 'csv/ldap'

describe Csv::Ldap do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @ldap = Csv::Ldap.new(host: 'localhost',
                          port: 389,
                          auth: {
                            method: :simple,
                            username: 'cn=admin,dc=example,dc=org',
                            password: 'secret'
                          })
  end

  describe 'reading from csv and upload to ldap' do
    it 'should check if connected to ldap' do
      expect(@ldap.bind).to eq(true)
    end

    it 'should check if input csv file have expected headers' do
      expect do
        @ldap.import(@fixtures_path + '/invalid_data.csv')
      end.to raise_error('Require headers to process the file.')
    end

    it 'should be success' do
      @ldap.delete dn: "cn=John Doe, #{Csv::Ldap::DEFAULT_TREE_BASE}"
      @ldap.delete dn: "cn=Jeannine Sylviane, #{Csv::Ldap::DEFAULT_TREE_BASE}"

      @ldap.import(@fixtures_path + '/valid_data.csv')
      expect(@ldap.errors.empty?).to eq(true)
    end
  end

  describe 'writing to csv from ldap' do
    before(:each) do
      @ldap.delete dn: "cn=John Doe, #{Csv::Ldap::DEFAULT_TREE_BASE}"
      @ldap.delete dn: "cn=Jeannine Sylviane, #{Csv::Ldap::DEFAULT_TREE_BASE}"
      @ldap.import(@fixtures_path + '/valid_data.csv')
    end

    context 'should generate csv' do
      before(:each) do
        @output_file_path = @fixtures_path + '/ldap_data_output.csv'
        @ldap.export(output_file_path: @output_file_path)
      end

      it 'creates a results csv file' do
        expect(File.file?(@output_file_path)).to be true
      end

      it 'without filter with valid search results' do
        data = CSV.read(@output_file_path)
        expect(data.flatten).to include('John Doe')
      end

      it 'without filter with valid search count' do
        data = CSV.read(@output_file_path)
        expect(data.size).to be > 1
      end
    end

    context 'should generate csv with specific filter' do
      before(:each) do
        filter = Net::LDAP::Filter.eq('cn', 'John*')
        @output_file_path = @fixtures_path + '/ldap_data_output_with_filter.csv'
        @ldap.export(output_file_path: @output_file_path, filter: filter)
      end

      it 'creates a results csv file' do
        expect(File.file?(@output_file_path)).to be true
      end

      it 'with filter with valid search results' do
        data = CSV.read(@output_file_path)
        expect(data.flatten).to include('John Doe')
      end

      it 'with filter with valid search count' do
        data = CSV.read(@output_file_path)
        expect(data.size).to eq(2)
      end
    end

    after(:each) do
      @ldap.delete dn: "cn=John Doe, #{Csv::Ldap::DEFAULT_TREE_BASE}"
      @ldap.delete dn: "cn=Jeannine Sylviane, #{Csv::Ldap::DEFAULT_TREE_BASE}"
    end
  end
end
