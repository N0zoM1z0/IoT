<% web_include_file("base64.js"); %>
function encode_data(val)
{
	return encode64(val);
} 
function decode_data(val)
{
	return decode64(val);
}
