defmodule Chat.GuardianSecretKey do
  def fetch do
    JOSE.JWK.from_pem_file("priv/fixture/rsa-2048.pub")
  end
end
