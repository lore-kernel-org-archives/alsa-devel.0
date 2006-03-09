From: "Hank Ivy" <hankivy@hot.rr.com>
Subject: cannot find input file: src/pcm/makefile.in
Date: Thu, 9 Mar 2006 11:28:54 -0600
Message-ID: <000001c6439e$f4eca100$6401a8c0@XP1>
References: <20060307194211.1D74D13576@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060307194211.1D74D13576@sc8-sf-spam2.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Regardless of the error message, I thank all of you.  Now my Linux
system has sound.  How do you recommend that I keep my sound software up
to date?

I have a riptide combo sound/modem/game-port card.
I checked out the ALSA CVS source.

The alsa-driver, and alsa-kernel directories seemed to compile and
install ok.  The PySol game plays music, and has sound effects.

The "./cvscompile" command in the alsa-lib directory ran a long time,
and stopped with the following error message.
config.status: error: cannot find input file: src/pcm/makefile.in

The "./cvscompile --disable-pcm" command in the alsa-lib directory ran a
long time, and stopped with the same error message.

The "./cvscompile" command in the alsa-utils directory seemed to compile
and install ok.

Hank Ivy




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
