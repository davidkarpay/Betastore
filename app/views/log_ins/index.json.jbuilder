json.array!(@log_ins) do |log_in|
  json.extract! log_in, 
  json.url log_in_url(log_in, format: :json)
end
