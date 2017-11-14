module Helpers
  def retsly_mock(path: nil, vendor_id: nil, prefix: nil)
    WebMock.reset!
    full_path = combined_path(prefix, vendor_id, path)
    data = fixture_file(full_path)
    WebMock
      .stub_request(:get, url_path(full_path))
      .to_return(body: data)
  end

  def retsly_mock_where(path: nil, vendor_id: nil, prefix: nil, query_string: nil)
    WebMock.reset!
    full_path = combined_path(prefix, vendor_id, path)
    data = fixture_file(full_path, 'where')
    WebMock
      .stub_request(:get, url_path(full_path, query_string))
      .to_return(body: data)
  end

  private

  def combined_path(prefix, vendor_id, path)
    [prefix, vendor_id, path].compact.join('/')
  end

  def url_path(full_path, query_string = nil)
    url = 'https://rets.io/api/v1/'
    "#{url}#{full_path}?access_token=#{access_token}#{query_string}"
  end

  def fixture_file(path, where = nil)
    File.read(SPEC_PATH + "/spec/fixtures/#{[path, where].compact.join('_')}.json")
  end
end
