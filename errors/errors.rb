require 'yaml'

class Error
  
  attr_accessor :error_container

  ERRORS = [
    {:number => "0", :code => 01, :message => "Not valid Account", :description => "" },
    {:number => "1", :code => 02, :error => "Not Balance", :description => "" },
    {:number => "2", :response_code => 03, :response_desc => "Bad Request"},
    {:number => "3", :response_code => 04, :response_desc => "Required Account Number", :description => ""}
  ]

  MAGIC_NUMBERS = [
    {:number => "0", :service => "service1", :action => "query", :partner_code => "code", :partner_message => "message"},
    {:number => "1", :service => "service1", :action => "pay", :partner_code => "code", :partner_message => "error"},
    {:number => "2", :service => "service2", :action => "query", :partner_code => "response_code", :partner_message => "response_desc"},
    {:number => "3", :service => "service2", :action => "pay", :partner_code => "response_code", :partner_message => "response_desc"}
  ]  

  def get_error_params(service,action)
    error_params = file_error['partner']['services'][service]['methods'][action]['error_params']
  end
  
  def read account_number
    magic_param = nil
    MAGIC_NUMBERS.each do |item|
      if item[:number] == account_number
        magic_param = item
      end
    end
    
    if magic_param.nil?
      return exception_raised = {
        code: "00000",
        message: "unmapped"
      }
    end

    a_error = get_error (account_number)

    config = get_error_params(magic_param[:service],magic_param[:action])

    if config.has_key?(magic_param[:partner_code]) && config.has_key?(magic_param[:partner_message]) then
      exception_raised = {
        code: a_error[magic_param[:partner_code].to_sym],
        message: a_error[magic_param[:partner_message].to_sym]
      }
    else
      exception_raised = {
        code: "00000",
        message: "unmapped"
      }
    end
    exception_raised
  end

  def get_error magic
    ERRORS.each do |item|
      if item[:number] == magic
        return item
      end
    end
  end

  private 

  def file_error
    @error_container =  @error_container || YAML.load_file(File.expand_path('../errors.yml', __FILE__))
  end

end

new_error = Error.new
puts new_error.read "6"
