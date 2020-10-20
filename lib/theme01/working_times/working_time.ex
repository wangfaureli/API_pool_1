defmodule Theme01.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Theme01.Acounts.User
  
  schema "workingtimes" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end])
    # |> validate_format(:start, ~r/\d{4}-[0-1]\d-[0-3]\d [0-2]\d:[0-6]\d:[0-6]\d/, [message: "Please input a valid dateFormat"])
    # |> validate_format(:end, ~r/\d{4}-[0-1]\d-[0-3]\d [0-2]\d:[0-6]\d:[0-6]\d/, [message: "Please input a valid dateFormat"])
  end
end
