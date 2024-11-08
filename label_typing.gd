extends Label

# Переменные для хранения полного текста и скорости печати
var typing_speed: float = 0.05  # Время задержки между символами

# Функция для запуска печати текста
func start_typing(full_text):
	text = ""  # Очищаем текст
	await start_typing_text(full_text)

# Корутина для посимвольного появления текста
func start_typing_text(text_to_type: String):
	for i in range(text_to_type.length()):
		text += text_to_type[i]  # Добавляем символ к тексту
		await get_tree().create_timer(typing_speed).timeout  # Ожидание перед добавлением следующего символа

# Вызываем печать текста, например, при запуске сцены
func _ready():
	text = ""
