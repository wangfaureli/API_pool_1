defmodule Theme01.WorkingTimes do
  @moduledoc """
  The WorkingTimes context.
  """

  import Ecto.Query, warn: false
  alias Theme01.Repo

  alias Theme01.WorkingTimes.WorkingTime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTime{}, ...]

  """
  def list_workingtimes(%{"user_id" => user_id, "id" => id}) do
    WorkingTime
    |> with_user(user_id)
    |> with_id(id)
    |> Repo.one()
  end

  def with_id(query, id) do
    query
    |> where([w], w.id == ^id)
  end

  def list_workingtimes(%{"user_id" => user_id, "end" => the_end, "start" => the_start}) do
    WorkingTime
    |> with_user(user_id)
    |> in_times(%{"end" => the_end, "start" => the_start})
    |> Repo.all()
  end

  def list_workingtimes(%{"user_id" => user_id, "end" => the_end}) do
    WorkingTime
    |> with_user(user_id)
    |> in_times(%{"end" => the_end})
    |> Repo.all()
  end

  def list_workingtimes(%{"user_id" => user_id, "start" => the_start}) do
    WorkingTime
    |> with_user(user_id)
    |> in_times(%{"start" => the_start})
    |> Repo.all()
  end

    
  def list_workingtimes(%{"user_id" => user_id}) do
    WorkingTime
    |> with_user(user_id)
    |> Repo.all()
  end

    
  def in_times(query, %{"end" => the_end, "start" => the_start}) do
    query
    |> where([w], w.start > ^the_start)
    |> where([w], w.end < ^the_end)
  end
  
  def in_times(query, %{"start" => the_start}) do
    query
    |> where([w], w.start > ^the_start)
    
  end

  def in_times(query, %{"end" => the_end}) do
    query
    |> where([w], w.end < ^the_end)
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id) do
    WorkingTime
    |> Repo.get!(id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}, user_id) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Ecto.Changeset.cast(user_id, [:user_id])
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end

  def get_time(time) do
    {:ok, result} = Timex.format(time, "{YYYY}-{M}-{D} {h24}:{m}:{s}")
    result
  end

  def with_user(query, user_id) do
    query
    |> where([c], c.user_id == ^user_id)
  end

  def get_clocks_by_user_id(user_id) do
    Clock
    |> with_user(user_id)
    |> Repo.all()
  end

  def get_working_times_by_user_id(user_id) do
    WorkingTime
    |> with_user(user_id)
    |> Repo.all()
  end
end
