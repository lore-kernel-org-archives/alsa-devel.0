From: "Mirabella, Mathew J" <Mathew.Mirabella@team.telstra.com>
Subject: Audigy 2 issues and alsa freezing.
Date: Fri, 28 Mar 2003 12:18:12 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <73388857A695D31197EF00508B08F2980A00EEA7@ntmsg0131.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "J. Scott Amort" <jsamort@telus.net>, alsa-devel list <alsa-devel@lists.sourceforge.net>, alsa-user list <alsa-user@lists.sourceforge.net>, sound-list list <sound-list@redhat.com>
Cc: emacspeak list <emacspeak@cs.vassar.edu>
List-Id: alsa-devel@alsa-project.org


I installed the alsa stuff from cvs and was able to get sound from the =
audigy 2, but only from the rear and sub woofer ports, and also from the =
digital port, but not from the 3rd analog port on the back (left and =
right front).  Is there a setting to make alsa work for a 2 speaker =
system?

As for getting sound, it seems ok except for the following:
1.  lots of pops and scratchy sounds when the sound changes.
2.  the sound stops completely after a few seconds.

btw: what i am doing is using ibm via voice outloud (a text to speech =
synth) with emacspeak (an audio interface to emacs).

also btw:  i seem to have had some slightly better luck with the emu10k1 =
drivers from cvs from
http://sourceforge.net/projects/emu10k1
http://sourceforge.net/cvs/?group_id=3D44773
Rather than alsa,=20

Thanks for any help.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
