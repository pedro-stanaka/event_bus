defmodule EventBus.Model.Event do
  @moduledoc """
  Structure and type for Event model
  """

  @enforce_keys [:id, :topic, :data]

  defstruct [
    :id,
    :transaction_id,
    :topic,
    :data,
    :initialized_at,
    :occurred_at,
    :source,
    :ttl
  ]

  @typedoc """
  Defines the Event struct.

  * :id - Identifier
  * :transaction_id - Transaction identifier, if event belongs to a transaction
  * :topic - Topic name
  * :data - Context
  * :initialized_at - When the process initialized to generate this event
  * :occurred_at - When it is occurred
  * :source - Who created this event: module, function or service name are good
  * :ttl - Time to live value
  """
  @type t :: %__MODULE__{
          id: String.t() | integer(),
          transaction_id: String.t() | integer(),
          topic: atom(),
          data: any(),
          initialized_at: integer(),
          occurred_at: integer(),
          source: String.t(),
          ttl: integer()
        }

  @doc """
  Duration of the event, and simple answer of how long does it take to generate
  this event
  """
  @spec duration(__MODULE__.t()) :: integer()
  def duration(%__MODULE__{
        initialized_at: initialized_at,
        occurred_at: occurred_at
      })
      when is_integer(initialized_at) and is_integer(occurred_at) do
    occurred_at - initialized_at
  end

  def duration(_) do
    0
  end
end
