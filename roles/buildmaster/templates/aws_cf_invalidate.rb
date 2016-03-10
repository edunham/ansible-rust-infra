require 'rubygems'
require 'hmac-sha1'
require 'net/https'
require 'base64'

s3_access='{{ aws_creds.access_key }}'
s3_secret='{{ aws_creds.secret_key }}'
cf_distribution='{{ cf_invalidate.cf_distribution }}'

if ARGV.length < 1
  puts "usage: aws_cf_invalidate.rb file1.html dir1/file2.jpg ..."
  exit
end

paths = '<Path>/' + ARGV.join('</Path><Path>/') + '</Path>'

date = Time.now.utc
date = date.strftime("%a, %d %b %Y %H:%M:%S %Z")
digest = HMAC::SHA1.new(s3_secret)
digest << date

uri = URI.parse('https://cloudfront.amazonaws.com/2010-08-01/distribution/' + cf_distribution + '/invalidation')

req = Net::HTTP::Post.new(uri.path)
req.initialize_http_header({
  'x-amz-date' => date,
  'Content-Type' => 'text/xml',
  'Authorization' => "AWS %s:%s" % [s3_access, Base64.encode64(digest.digest)]
})

req.body = "<InvalidationBatch>" + paths + "<CallerReference>ref_#{Time.now.utc.to_i}</CallerReference></InvalidationBatch>"

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
res = http.request(req)

puts res.code
puts res.body
