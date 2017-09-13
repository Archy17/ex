defmodule Gs do

  use GenServer


  def start_link() do
  
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  
  
       ##GenServer.start_link(__MODULE__, [])
  end


  def create(name, adress, bissnes) do
    GenServer.call(Gs, {:create, name, adress, bissnes})
  end
  
  def read(name) do
    GenServer.call(Gs, {:read , name})
  end

  def close() do
    GenServer.call(Gs, {:close})
  end
  
  


  def init([]) do
    {:ok, :dets.open_file(:md, [type: :set])}
  end
  
  

  def handle_call({:create, name, adress, bissnes}, _from, state) do
    case :dets.lookup(:md, name)  do
      [] ->
        :dets.insert(:md, {name, adress,bissnes})
        {:reply, {:oke}, state}
      _else -> 
        {:reply, {:error}, state}
    end
  end
 
  def handle_call({:read , name}, _from, state) do
    case :dets.lookup(:md, name)  do
      [] ->
        :dets.lookup(:md, name)
        {:reply, {:error}, state}
      _else -> 
        {:reply, :dets.lookup(:md, name), state}
    end
  end

  def handle_call({:close}, _From, state) do 
    :dets.close(:md)	
    {:reply, {:okeKlose}, state}
  end


  def handle_info(_info, state) do
    {:noreply, state}
  end

  def terminate(_reason, _state) do
    {:ok}
  end

  def code_change(_old_version, state, _extra) do
    {:ok, state}
  end

end