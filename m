From: Patrick Dumais <pat@dumaisnet.ca>
Subject: hardware channel mixing
Date: Sun, 29 Aug 2004 11:03:09 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408291058200.4131@pat.dumaisnet.ca>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


When I read a description of what the soundblaster Live features, I notice
they say "131 hardware channels". Now is this what I think it is? does it
mean that I can actualy write multiple (upto 131) sounds and let the card
mix it by itself?

If so, I haven't seen any documentation about this. is there a
snd_pcm_writen(buffer, channel_where_to_write, Size) or something like
that? I would really like to know where to get that documentation.

Thank you


Patrick Dumais


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
