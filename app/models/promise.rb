class Promise < ApplicationRecord
  enum status: [:'in progress', :abandoned, :done]
end
