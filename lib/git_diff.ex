  
  Returns `{:ok, [%GitDiff.Patch{}]}` in case of success, `{:error, :unrecognized_format}` otherwise.
  @spec parse_patch(String.t) :: {:ok, [%GitDiff.Patch{}]} | {:error, :unrecognized_format}
  def parse_patch(git_diff) do
    try do
      parsed_diff =
        git_diff
        |> String.splitter("\n")
        |> split_diffs()
        |> process_diffs()
        |> Enum.to_list()
        
      if Enum.all?(parsed_diff, fn(%Patch{} = _patch) -> true; (_) -> false end) do
        {:ok, parsed_diff}
      else
        {:error, :unrecognized_format}
      end
    rescue
      _ -> {:error, :unrecognized_format}
    end
      raise "Invalid diff type"