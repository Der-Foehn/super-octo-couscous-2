

SSH Key auf USB-Stick, Stick verschlüssen (BitLocker)

sudo apt-get update
sudo apt-get dist-upgrade

---------------------

SwapPartition erstellen

cd /
sudo dd if=/dev/zero of=swapfile bs=1M count=3000
sudo mkswap swapfile
sudo swapon swapfile
sudo nano etc/fstab

und das ans Ende der txt datei schreiben inkl. Enter am Ende der Zeile
/swapfile none swap sw 0 0

---------------------

den Ordner .ssh erstellen und die Datei 

cd ~
mkdir .ssh
chmod 700 .ssh
cd .ssh
sudo nano authorized_keys
chmod 600 ~/.ssh/authorized_keys
->jetzt den ssh-rsa key da einfügen aus dem grauen Feld inkl. Enter am Ende der Zeile, dann STRG+O -> Enter -> STRG+X

sudo chmod 600 authorized_keys

Damit ist die doofe Key-Datei auf dem Server erstellt....

-------------------- 

SSH-Zugang aktivieren

nano /etc/ssh/sshd_config

da suchen wir die Punkte und ändern diese entsprechend ggf. die "#" löschen
 
PasswordAuthentication no
PubkeyAuthentication yes
ChallengeResponseAuthentication no
AuthorizedKeysFile      .ssh/authorized_keys .ssh/authorized_keys2

STRG+O -> Enter -> STRG+X

sudo systemctl reload sshd

--------------------

Testen obs geklappt hat!

WIIICHTIG!! DIE ERSTE INSTANZ VON PUTTY ERST SCHLIEßEN WENN DAS MIT DEM SSH KEY GEKLAPPT HAT!!! 
SONST SPERRT MAN SICH AUS SEINEM SERVER AUS!!!

Eine zweite Instanz von Putty öffnen, oben muss nun bei "Host Name (or IP address)
"root@158.216.36.100", stehen

also ->benutzer @ Server IP<-

und auf der linken Seite unter dem Punkt Connection->SSH->Auth unten auf Browse und die SSH Private Key Datei suchen und einbinden
dann links in der liste nach ganz oben auf "Session" in der mitte im Feld "Saved Sessions" einen Namen vergeben und rechts an der Seite auf
Save Klicken... damit ist die Session für später gespeichert. Geht einfacher als alles eintippen...

Open klicken und hoffen das wir uns auf unseren Server verbinden...

Falls ja... wunderbar! falls nicht nochmal melden...

Die Private Key Datei auf einen USB-Stick packen, den am besten noch verschlüsseln und gut wegpacken. 

----------------------------

UFW AUSSCHALTEN!!!

sudo ufw disable

crontab -e

/MN-SETUP/northern-2.0.1#