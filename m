From: "John Shepherd" <g99s2711@campus.ru.ac.za>
Subject: writing an alsa/1394 driver.
Date: Mon, 28 Oct 2002 20:35:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c27eb0$c0e82b60$2b7be792@ict.ru.ac.za>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi -

sorry if this gets gotten twice (but the first was i sent was blocked,
or at least delayed, and i needed an answer fairly quickly...)

anyway i am attempting to write a driver to emulate a sound card but
that sends the audio over firewire (1394).  so i was wondering how i
could possibly modify say, the snd_dummy module to send audio to the
1394 drivers (instead of a sound card as normal snd-crd drivers do)?

so what i am trying to say is how would one extract the audio data from
snd-dummy?  and furthermore how does it leave the snd-dummy?

thanx (in advancinium)!

<ps. sorry if you get this bastard twice; i tried sending a mail, and it
did not like me 'cos i was not subscribed, so i subscribed to get it
through...>

 - j

=====================================
john shepherd <g99s2711@campus.ru.ac.za>

dept. of computer science
rhodes university 
grahamstown
6140
=====================================




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
