# Course of Mental Disease — Мобильное приложение для самонаблюдения при ментальных расстройствах

**Course of Mental Disease** — это iOS-приложение, разработанное для помощи пользователям в осознанном отслеживании течения ментальных и соматических состояний. Основной целью проекта является создание цифрового пространства, где пользователь может фиксировать, анализировать и визуализировать изменения в своём психоэмоциональном и физическом здоровье.
Проект направлен на поддержку людей, находящихся в процессе диагностики, лечения или наблюдения за ментальными расстройствами. Он может использоваться самостоятельно, в тандеме с терапевтом или как вспомогательный инструмент в телемедицинских решениях.


### Цели приложения:
- Поддержка саморефлексии: записывание ощущений, симптомов и состояний.
- Создание регулярной привычки наблюдения: через удобный и ненавязчивый интерфейс.
- Масштабируемость и адаптивность: архитектура приложения легко позволяет добавлять новые разделы (например, для тревоги, сна, настроения и т. п.).


### Целевая аудитория:
- Люди с ментальными и/или психосоматическими расстройствами.
- Пациенты, находящиеся под наблюдением психиатров, психотерапевтов, неврологов.
- Исследователи и клиницисты (в рамках возможной интеграции).
- Широкая аудитория, заинтересованная в самонаблюдении и заботе о психическом здоровье.


### Основные технологии и стек:
- Язык программирования -	Swift

- UI-фреймворк	- SwiftUI.

- Backend - Supabase (Auth + Realtime Database + Storage) - реляционная база данных, использующая SQL-синтаксис. Используется для авторизации, хранения и извлечения данных.

- Архитектура -	Feature-based MVVM + DI. Такая архитектура упрощает поддержку, масштабирование и повторное использование компонентов. Архитектура разделяет приложение на:
	- Features: Каждый модуль (Auth/Profile/Somatics..) содержит свои views и viewmodels:
		- View: SwiftUI-представления, реагирующие на @Published-состояния ViewModel.
		- ViewModel: бизнес-логика, взаимодействие с сервисами и состояние интерфейса.

    - Общие компоненты вынесены отдельно:
		- Models: данные и сущности.
    	- Service: логика работы с внешними источниками (Supabase, хранилище и пр.).
		- DI: Внедрение зависимостей реализовано через современный DI-фреймворк Factory. Который позволяет легко подменять реализации в тестах или при смене backenda'а и позволяет устанавливать область видимости для сервисов.

- Асинхронность -	async/await для взаимодействия с Supabase SDK.

- Тестирование -	XCTest Unit Tests с моками и переопределением зависимостей через Factory.

---
## Текущие возможности приложения
На данный момент Course of Mental Disease предоставляет базовый набор возможностей необходимых для самонаблюдения за соматическими состояниями пользователя:

### Навигация и поток входа
- EntryPoint определяет сценарий запуска (загрузочный экран -> экран авторизации или основное приложение).
- Навигация через FlowViews, которые позволяют переходить между модулями и внутри модулей.
- Простой и доступный пользовательский интерфейс на SwiftUI.

### Аутентификация
- Регистрация нового пользователя.
- Вход по email и паролю.
- Хранение сессии и автоматический вход (Supabase Auth).

<img src="images/LoadScreenAnimation.gif" height="300" /> <img src="images/LogInScreen.png" height="300" /> <img src="images/SignUpScreen.png" height="300" /> <img src="images/EmptySectionScreen.png" height="300" /> <img src="images/SectionScreen.png" height="300" />

### Профиль
- Просмотр и редактирование персональной информации.
- Привязка профиля к текущим данным в Supabase.
- Реактивное обновление UI при изменении данных.

<img src="images/ProfileScreen.png" height="300" /> <img src="images/EditableProfileScreen.png" height="300" />

### Соматические данные
- Ведение дневника соматических симптомов.
- Добавление и редактирование записей: показатель, дата, интенсивность.
- Хранение данных в Supabase с последующей загрузкой в реальном времени и отображением на индикотарох для опеределеия динамики показателя за временной промежуток.
- Интерактивный список симптомов по дате, с возможностью перехода к записи за определённую дату, для редактирования или удаления записи.

<img src="images/EmptySomaticScreen.png" height="300" /> <img src="images/AddRecordScreen.png" height="300" /> <img src="images/RecordListScreen.png" height="300" /> <img src="images/RecordEditScreen.png" height="300" /> <img src="images/SomaticScreen.png" height="300" /> <img src="images/SomaticRangeScreen.png" height="300" />

### Тестирование
Тесты написаны для бизнес-логики экранов авторизации и регистрации.

---
## Потенциал развития
Проект заложен как гибкая и масштабируемая основа, которую можно развивать в нескольких направлениях — как для пользователя, так и для профессионального/медицинского применения.

### Новые фичи
- Ментальные данные: трекинг настроения, тревожности, сна, когнитивных симптомов.
- Графики и аналитика: визуализация динамики симптомов во времени.
- Push-уведомления: напоминания о заполнении дневника, приёме лекарств.
- Календарь / хронология: представление симптомов в виде таймлайна.

### Интеграция с экосистемой здоровья
- HealthKit: получение и анализ данных о сне, активности и пульсе.
- AI-помощник: генерация рекомендаций на основе истории состояний.
- Интеграция с терапевтами: безопасный экспорт или расшаривание данных специалисту.

### Backend и многопользовательская работа
- Поддержка роли терапевта и обмена данными между пользователями.
- Локальное кэширование и offline-режим.

### Тесты и CI
- Интеграция CI/CD пайплайна для автоматической сборки и тестов.
- Покрытие тестами всех бизнес-критичных модулей.
- Внедрение UI-Тестов.

---
## Концептуальная цель
Создание инструмента цифровой саморефлексии, который можно использовать: самостоятельно (в виде трекера), в связке с терапевтом (через экспорт данных), или как модуль для B2B-решений в телемедицине и исследованиях.

