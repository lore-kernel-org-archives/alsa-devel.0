From: Paul Davis <paul@linuxaudiosystems.com>
Subject: ALSA CVS and JACK?
Date: Tue, 25 Feb 2003 12:37:41 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302251737.h1PHbfk20233@linuxaudiosystems.com>
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

can jaroslav or takashi fill me in on the current state of ALSA CVS
with respect to JACK? there have been many, many reports of JACK
crashing machines when run with recent ALSA CVS in real-time mode, and
mentions here on alsa-devel of configure-time JACK detection that
causes certain code to be commented out, or something like that.

we are about to do a cross-DAW benchmark of ardour with most
commercial apps, and the people running the test need to install
ALSA. since they will run JACK in RT mode, i need to be sure that this
is not going to crash their system, and would like to be able to
provide assistance to others in this matter.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
