defmodule VitalSignsWeb.VitalChannel do
  use Phoenix.Channel

  alias VitalSigns.VitalSigns.Tracking
  alias VitalSigns.Repo

  def join("specialist:" <> id, _payload, socket) do
    IO.puts(id)
    {:ok, socket}
  end

  def handle_in("vital_signs", payload, socket) do
    IO.inspect payload

    calories = %{
      "client_id" => payload["id"],
      "vital_sign_id" => payload["caloriesId"],
      "value" => payload["calories"]
    }

    heartRate = %{
      "client_id" => payload["id"],
      "vital_sign_id" => payload["heartRateId"],
      "value" => payload["heartRate"]
    }

    steps = %{
      "client_id" => payload["id"],
      "vital_sign_id" => payload["stepsId"],
      "value" => payload["steps"]
    }


    %Tracking{}
    |> Tracking.changeset(calories)
    |> Repo.insert()

    %Tracking{}
    |> Tracking.changeset(heartRate)
    |> Repo.insert()

    %Tracking{}
    |> Tracking.changeset(steps)
    |> Repo.insert()

    

    broadcast_from!(socket, "specialist", payload)
    {:noreply, socket}
  end

end
