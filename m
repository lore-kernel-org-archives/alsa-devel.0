From: Richard Bown <bownie@bownie.com>
Subject: sequencing ALSA ports and clients
Date: Wed, 10 Apr 2002 14:38:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204101341.AFH83147@msgdirector1.onetel.net.uk>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok, earlier I sent this question to LAD but this is probably a better place
to be asking it.  Apologies if you've already seen it.

Basically I'm still confused about synth clients and ports.  My SBLive presents
four synth ports as default.  I create a port and subscribe or connect_to a specfic
SBLive port and client.  When I'm sequencing out to this port should I be multiplexing
among the other ports to exploit the synth's full polyphony?  Should I be adding to
the ports myself or can I get away with just using the one?  If the latter then why
are there four ports made available?  I'm sure there's a dunce's document someone
can point me to!

R
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com
