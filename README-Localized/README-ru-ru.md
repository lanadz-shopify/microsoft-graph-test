## Пример приложения на Ruby, подключающегося к Office 365 и использующего Microsoft Graph

[ ![Состояние сборки](https://api.travis-ci.org/microsoftgraph/ruby-connect-rest-sample.svg?branch=master)](https://travis-ci.org/microsoftgraph/ruby-connect-rest-sample)

Подключение к Office 365 — это первый шаг, который должно выполнить каждое приложение, чтобы начать работу со службами и данными Office 365. В этом примере показано, как подключить и вызвать один API с помощью Microsoft Graph (прежнее название — единый API Office 365), а также использовать платформу Office UI Fabric для работы с Office 365.

Перейдите на страницу [Начало работы с API Office 365](http://dev.office.com/getting-started/office365apis?platform=option-ruby#setup) для упрощенной регистрации, чтобы ускорить запуск этого примера.

![Снимок экрана с примером приложения на Ruby, подключающегося к Office 365](../readme-images/O365-Ruby-Microsoft-Graph-Connect.png)  

> Примечание. Подробное описание кода см. в статье [Вызов Microsoft Graph в приложении на Ruby](https://graph.microsoft.io/ru-ru/docs/platform/ruby).

## Предварительные требования

Чтобы можно было воспользоваться примером приложения на Ruby, подключающегося к Office 365, необходимы перечисленные ниже компоненты.

* Ruby 2.1 для запуска приложения на сервере разработки.
* Платформа Rails (пример протестирован на платформе Rails 4.2).
* Диспетчер зависимостей Bundler.
* Интерфейс веб-сервера для Ruby (Rack).
* Учетная запись Office 365. Вы можете [подписаться на план Office 365 для разработчиков](https://aka.ms/devprogramsignup), включающий ресурсы, которые необходимы для создания приложений Office 365.

    > **Примечание**. <br />
	Если у вас уже есть подписка, при выборе приведенной выше ссылки откроется страница с сообщением *К сожалению, вы не можете добавить это к своей учетной записи*. В этом случае используйте учетную запись, сопоставленную с текущей подпиской на Office 365.<br /><br />
	Если вы уже вошли в систему Office 365, на кнопке входа, отображенной после выбора предыдущей ссылки, появится сообщение *Невозможно обработать ваш запрос*. В этом случае выйдите из Office 365 на этой же странице и повторно войдите в систему.
* Клиент Microsoft Azure для регистрации приложения. В Azure Active Directory (AD) доступны службы идентификации, которые приложения используют для проверки подлинности и авторизации. Пробную подписку можно получить на сайте [Microsoft Azure](https://account.windowsazure.com/SignUp).

    > **Внимание!**<br />
	Убедитесь, что ваша подписка Azure привязана к клиенту Office 365. Для этого просмотрите запись в блоге команды Active Directory, посвященную [созданию нескольких каталогов Microsoft Azure AD и управлению ими](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx). Инструкции приведены в разделе о **добавлении нового каталога**. Дополнительные сведения см. в статье [Как настроить среду разработки для Office 365](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription) и, в частности, в разделе **Связывание Azure AD и учетной записи Office 365 для создания приложений и управления ими**.
* Значения [```client ID```](app/Constants.rb#L29), [```key```](app/Constants.rb#L30) и [```reply URL```](app/Constants.rb#L31) приложения, зарегистрированного в Azure. Этому приложению необходимо предоставить разрешение **Отправка почты от имени пользователя** для **Microsoft Graph**. Дополнительные сведения см. в разделе [Регистрация браузерного веб-приложения на портале управления Azure](https://msdn.microsoft.com/office/office365/HowTo/add-common-consent-manually#bk_RegisterWebApp) и [предоставьте подключающемуся приложению необходимые разрешения](https://github.com/OfficeDev/O365-Ruby-Microsoft-Graph-Connect/wiki/Grant-permissions-to-the-Connect-application-in-Azure).

     > **Примечание**. <br />
	 При регистрации приложения укажите *http://localhost:3000/auth/azureactivedirectory/callback* как значение параметра **URL-адрес входа**.

## Настройка и запуск приложения

1. Если у вас еще нет Bundler и Rack, их можно установить с помощью приведенной ниже команды.

	```
	gem install bundler rack
	```
2. В файле [environment.rb](config/environment.rb) выполните указанные ниже действия.
    1. Замените *ENTER_YOUR_CLIENT_ID* на идентификатор клиента для зарегистрированного в Azure приложения.
    2. Замените *ENTER_YOUR_SECRET* на ключ для зарегистрированного в Azure приложения.
    3. Замените *ENTER_YOUR_TENANT* на название клиента в формате *your_tenant.onmicrosoft.com*.
3. Установите приложение Rails и зависимости с помощью указанной ниже команды.

	```
	bundle install
	```
4. Чтобы запустить приложение Rails, введите приведенную ниже команду.

	```
	rackup -p 3000
	```
5. Введите адрес ```http://localhost:3000``` в веб-браузере.

## Вопросы и комментарии

Мы будем рады получить от вас отзывы о примере приложения на Ruby, подключающегося к Office 365. Отправляйте нам свои вопросы и предложения в раздел этого репозитория, посвященный [проблемам](https://github.com/OfficeDev/O365-Ruby-Microsoft-Graph-Connect/issues).

Общие вопросы о разработке решений для Office 365 следует публиковать на сайте [Stack Overflow](http://stackoverflow.com/questions/tagged/Office365+API). Обязательно помечайте свои вопросы и комментарии тегами [Office365] и [API].
  
## Дополнительные ресурсы

* [Общие сведения о платформе API Office 365](https://msdn.microsoft.com/office/office365/howto/platform-development-overview)
* [Начало работы с API Office 365](http://dev.office.com/getting-started/office365apis)
* [Обзор Microsoft Graph](http://graph.microsoft.io/)
* [Другие примеры приложений, подключающихся с использованием Microsoft Graph](https://github.com/officedev?utf8=%E2%9C%93&query=Microsoft-Graph-Connect)
* [Начальные проекты и примеры кода касательно API Office 365](https://msdn.microsoft.com/office/office365/howto/starter-projects-and-code-samples)
* [Office UI Fabric](https://github.com/OfficeDev/Office-UI-Fabric)

## Авторские права
(c) Корпорация Майкрософт (Microsoft Corporation), 2015. Все права защищены.
