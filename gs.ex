defmodule gs do
use GenServer



# Вспомогательный метод для запуска
def start_link do
GenServer.start_link(__MODULE__, [], [{:gs, __MODULE__}])
end

# Далее следуют функции обратного вызова,
# которые используются модулем GenServer


#{:ok, table} = :dets.open_file(:disk_storage, [type: :set])


def init([]) do
{:ok, :dets.open_file(:file_dets, [type: :set])}
end


#init([]) ->
#  {ok, dets:open_file(md,  [{type, set}])}.



def handle_call(request, _from, state) do
distance = request
reply = {:ok, fall_velocity(distance)}
new_state = %State{count: state.count + 1}
{:reply, reply, new_state}
end

def handle_cast(_msg, state) do
IO.puts("So far, calculated #{state.count} velocities.")
{:noreply, state}
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

# Функция для внутреннего использования
def fall_velocity(distance) do
:math.sqrt(2 * 9.8 * distance)
end

end