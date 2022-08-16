<h1 align="center">
    Character Sheet
</h1>

<h4 align="center"> 
    🚧  Character Sheet 🎲 Finished 🚧
</h4>

<p align="center">
 <a href="#-about-the-project">About</a> •
 <a href="#-setup">Setup</a> • 
 <a href="#-usage">Usage</a> • 
 <a href="#-technologies">Technologies</a> • 
 <a href="#-author">Author</a> • 
 <a href="#user-content--license">License</a>
</p>


## 💻 About the project

The "simple" character sheet app for player and GM.
But it was also made to play during a session, where you can manage your character, watch the dice roll on TV.

Just to let you know that the application was designed to play with everyone together in a room, where you have a tv with internet, if you are thinking of using it to play with other people online, unfortunately it won't work, but you can use it. it as character management, that's all.

## ⚙️ Setup
### Prerequisites to run on local machine
-   **[Git](https://git-scm.com)**
-   **[Ruby on rails](https://rubyonrails.org/)**
-   **[Postgresql](https://www.postgresql.org/)**
-   **[ImageMagick](https://imagemagick.org/index.php) and/or [libvips](https://github.com/libvips/libvips)**
---
First clone the repository.
```bash
git clone https://github.com/XandeKK/Character-Sheet.git
```
Go to Character-Sheet.
```bash
cd Character-Sheet
```
Install the dependencies.
```bash
bundle install
```
Migrate the database.
```bash
rake db:create db:migrate db:seed
```
Test your app to check if everything is ok.
```bash
rake test
```
Run web server.
```bash
rails s
```
Visit http://localhost:3000 in a browser.

If you want to access other devices besides the computer. To get this ip, search "How to find your IP address in my 'OS'".
```bash
rails s -b your-ip
```
Visit http://your-ip:3000 in a browser.

If there is any problem, report it to me.

---

### Prerequisites to run on heroku
-   **[Git](https://git-scm.com)**
-   **[A heroku account, obviously](https://signup.heroku.com/devcenter)**
-   **[Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli)**

---

First clone the repository.
```bash
git clone https://github.com/XandeKK/Character-Sheet.git
```
Go to Character-Sheet.
```bash
cd Character-Sheet
```
Create an app on Heroku CLI.
```bash
heroku create name-app
```
The Heroku CLI adds the Git remote automatically. Verify it is set with git config.
```bash
git config --list --local | grep heroku
```
Deploy the code.
```bash
git push heroku main
```
Add heroku-redis to make websocket work.
```bash
heroku addons:create heroku-redis:hobby-dev
```
Check if heroku redis is created.
```bash
heroku addons
```
Set your environment variable, replace your-app to your app url.
If you don't know the url of the site, just run `heroku apps:info` and you will see the WEB URL.
```bash
heroku config:set WEB_SOCKET_SERVER_URL=wss://your-app.com/cable
heroku config:set ALLOWED_REQUEST_ORIGINS=["https://your-app.com/",/http:\/\/your-app.*/]
```
Migrate the database.
```bash
heroku run rake db:migrate db:seed
```
Scale the web process.
```bash
heroku ps:scale web=1
```
Use to launch the app in the browser.
```bash
heroku open
```

If there is any problem, report it to me.

---

## 🎲 Usage

On the homepage you have a three way player, gm and tv.

- Player

On the player page, you have the function of managing the playable character.

On the page, there are also two input fields which are the server name and password. For you to connect to a server, there must be an adventure, to create an adventure go to the GM page.

Note: It is possible to connect to the server without the GM being connected.

- GM

On the gm page you have npc, enemy and adventure.

In the same way as on the player page, you can also use the npc or the enemy as a playable character.

On the adventures page, there you will be offered a server name, which you will share with the players.

It also has two buttons that will open a collapse, and within that collapse you can choose the npcs and enemies that will participate in the adventure session.
You may also notice that at the end there is a player slot.
This area is the players that are connected to the server, but if the player is connected, you must click on the open server button to view the players.

- TV

On the tv page, you have two input fields for server name and password.
and in the left corner of the page, is the chat, it will show the results of the dice that were played.

For you to be able to roll a dice, you have to enter the player, npc, enemy or adventures and click on the 'roller' button, which will open a popup/modal, giving you the option to choose the dice and play.
Remember that you have to be connected to the same server for this to work.

Note: It is possible to connect to the server without the GM being connected.

If you have any questions about something, you can contact me.

## 🛠 Technologies

The following tools were used in building the project:

-   **[Ruby on rails](https://rubyonrails.org/)**
-   **[Postgresql](https://www.postgresql.org/)**
-   **[Dice-box](https://github.com/3d-dice/dice-box)**

## 📝 License

This project is under license [MIT](./LICENSE).

Made with ❤️ by Alexandre Alves 👋🏽 [Contact](https://www.linkedin.com/in/alexandre-dos-santos-alves-707921206/)
