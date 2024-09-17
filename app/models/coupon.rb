require 'zip'

class Coupon < ApplicationRecord
  def generate_pass
    pass_json = {
      formatVersion: 1,
      passTypeIdentifier: "pass.com.app.kliperr",
      serialNumber: SecureRandom.uuid,
      teamIdentifier: "N7C26WC5U7",
      organizationName: "Kliperr",
      description: self.description || "Coupon",
      logoText: self.title || "Your Coupon",
      foregroundColor: "rgb(255, 255, 255)",
      backgroundColor: "rgb(0, 0, 0)",
      barcode: {
        message: self.code || "1234567890",
        format: "PKBarcodeFormatQR",
        messageEncoding: "iso-8859-1"
      }
    }.to_json

    pkpass_file = Zip::OutputStream.write_buffer do |zip|
      zip.put_next_entry('pass.json')
      zip.write pass_json
    end

    pkpass_file.string
  end
end
