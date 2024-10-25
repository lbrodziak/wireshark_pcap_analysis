# Define the base64 string (replace '<YourBase64String>' with the actual string)
$base64String = "<YourBase64String>"

# Decode the Base64 string to get the compressed byte array
$compressedBytes = [Convert]::FromBase64String($base64String)

# Create a memory stream from the compressed byte array
$compressedStream = [System.IO.MemoryStream]::new($compressedBytes)

# Create a DeflateStream to decompress the data
$decompressedStream = [System.IO.MemoryStream]::new()
$decompressor = [System.IO.Compression.DeflateStream]::new($compressedStream, [System.IO.Compression.CompressionMode]::Decompress)

# Copy the decompressed data to the output stream
$decompressor.CopyTo($decompressedStream)
$decompressor.Close()

# Get the decompressed bytes
$decompressedBytes = $decompressedStream.ToArray()

# Convert the decompressed byte array back to a string (UTF-8 encoding)
$output = [Text.Encoding]::UTF8.GetString($decompressedBytes)

# Display the output
Write-Output $output
