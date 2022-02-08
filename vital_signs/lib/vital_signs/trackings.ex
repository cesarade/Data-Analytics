defmodule VitalSigns.Trackings do
  import Ecto.Query
  alias VitalSigns.Repo
  alias VitalSigns.VitalSigns.{Tracking, VitalSign}


  def get_tracking_by_client_date_query(client_id, first_date, last_date) do
    # "df206c29-bfd0-448d-940b-c7ca37617f20"
    ndt_f = NaiveDateTime.from_iso8601!(first_date <> " 00:00:00")
    ndt_l = NaiveDateTime.from_iso8601!(last_date <> " 00:00:00")

    from t in Tracking,
    join: v in VitalSign, on: v.id == t.vital_sign_id,
    where: t.client_id == ^client_id and t.inserted_at >= ^ndt_f and t.inserted_at <= ^ndt_l,
    select: %Tracking{
      id: t.id,
      value: t.value,
      client_id: t.client_id,
      inserted_at: t.inserted_at,
      vital_sign_id: t.vital_sign_id,
      vital_sign_name: v.name,
      vital_sign_value_type: v.value_type
    }
  end


  def get_tracking_by_client_date(client_id, first_date, last_date) do
    result = get_tracking_by_client_date_query(client_id, first_date, last_date)
    Repo.all(result)
  end

end
