defmodule gs do

  use GenServer


  def start_link do
    {:ok, pid} = GenServer.start_link(gs, [], [{:gs, __MODULE__}])
  end


  def create(Name, Adress, Bissnes) do
    GenServer.call(pid, {:create, Name, Adress, Bissnes})
  end
  
  def read(Name) do
    GenServer.call(pid, {:read , Name})
  end

  def close() do
    GenServer.call(pid, {:close})
  end
  
  


  def init([]) do
    {:ok, :dets.open_file(:md, [type: :set])}
  end


  def handle_call({:create, Name, Adress, Bissnes}, _from, state) do
    case :dets.lookup(md, Name)  do
    [] ->
    :dets.insert(md, {Name, Adress,Bissnes})
    {reply, {oke}, State}
    _else -> 
    {:reply, {error}, State}
    end
  end
 
  def handle_call({:read , Name}, _from, state) do
    case :dets.lookup(md, Name)  do
    [] ->
    :dets.lookup(md, Name)
    {:reply, {error}, State}
    _else -> 
    {:reply, :dets.lookup(md, Name), State}
    end
  end

  def handle_call({close}, _From, State) do 
    :dets.close(md)	
    {:reply, {okeKlose}, State}
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