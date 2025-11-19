program SimpleEncapsulation;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  // Класс животного с инкапсуляцией
  TAnimal = class
  private
    FName: string;
    FAge: Integer;
  public
    // Конструктор - создает объект
    constructor Create(AName: string; AAge: Integer);

    // Get-методы - для чтения private полей
    function GetName: string;
    function GetAge: Integer;

    // Set-методы - для записи private полей с проверками
    procedure SetName(AName: string);
    procedure SetAge(AAge: Integer);
  end;

{ TAnimal }

// Конструктор - инициализирует объект
constructor TAnimal.Create(AName: string; AAge: Integer);
begin
  FName := AName;  // Устанавливаем имя
  FAge := AAge;    // Устанавливаем возраст
end;

// Get-метод для имени - возвращает значение private поля
function TAnimal.GetName: string;
begin
  Result := FName;
end;

// Get-метод для возраста - возвращает значение private поля
function TAnimal.GetAge: Integer;
begin
  Result := FAge;
end;

// Set-метод для имени - проверяет корректность перед установкой
procedure TAnimal.SetName(AName: string);
begin
  if AName <> '' then  // Проверка: имя не должно быть пустым
    FName := AName;
end;

// Set-метод для возраста - проверяет корректность перед установкой
procedure TAnimal.SetAge(AAge: Integer);
begin
  if AAge > 0 then  // Проверка: возраст должен быть положительным
    FAge := AAge;
end;

// Основная программа
var
  Cat: TAnimal;  // Объявляем переменную для объекта

begin
  // СОЗДАНИЕ ОБЪЕКТА
  Cat := TAnimal.Create('Барсик', 3);  // Создаем кота с именем и возрастом
  try
    // ЧТЕНИЕ ДАННЫХ через Get-методы
    Writeln('Имя: ', Cat.GetName);     // Получаем имя через метод
    Writeln('Возраст: ', Cat.GetAge);  // Получаем возраст через метод

    // ИЗМЕНЕНИЕ ДАННЫХ через Set-методы
    Cat.SetName('Мурка');  // Меняем имя через метод
    Cat.SetAge(4);          // Меняем возраст через метод

    // ПРОВЕРКА ИЗМЕНЕНИЙ
    Writeln('Новое имя: ', Cat.GetName);
    Writeln('Новый возраст: ', Cat.GetAge);
  finally
    // ОСВОБОЖДЕНИЕ ПАМЯТИ
    Cat.Free;  // Уничтожаем объект
  end;
  Readln;
end.
