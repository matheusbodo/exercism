defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count_nucleotides(to_charlist(strand), nucleotide, 0)
  end

  defp count_nucleotides([], _, count) do
    count
  end

  defp count_nucleotides([head | tail], nucleotide, count) do
    count_nucleotides(tail, nucleotide, is_nucleotide(head, nucleotide) + count)
  end

  defp is_nucleotide(char, nucleotide) do
    if char == nucleotide, do: 1, else: 0
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    count_histogram(strand)
  end

  defp count_histogram([]) do
    %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
  end

  defp count_histogram([head|tail]) do
    current_count = count_histogram(tail)
    %{current_count | head => current_count[head] + 1}
  end
end
