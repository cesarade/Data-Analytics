defmodule VitalSignsWeb.TrackingView do
  use VitalSignsWeb, :view

  def render("trackings.json", %{trackings: trackings}) do
    %{trackings: render_many(trackings, ClientView, "tracking.json")}
  end

  def render("tracking.json", %{tracking: tracking}) do
    %{
      value: tracking.firt_name,
      client_id: tracking.last_name,
      vital_sign_id: tracking.genre,
      vital_sign_name: tracking.user_name,
      vital_sign_value_type: tracking.email,
    }
  end

end
