defmodule Chat.GuardianSecretKey do
  def fetch do
    JOSE.JWK.from_pem_file("rsa-2048.pub")
  end
end
