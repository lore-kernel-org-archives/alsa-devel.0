From: Michal Seta <mis@creazone.com>
Subject: MIDI+USB - one way?
Date: Fri, 2 Aug 2002 00:15:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020802001554.48f2f13a.mis@creazone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi all,

I got a midisport2x2 interface.  I had it working with the usb-midi driver  but then I found out that alsa .rc3 had support for usb-midi.  So I got the CVS version and all compiled fine.  I had it working, too.  Now, for some strange reason, no matter what I try I am only able to get MIDI -out but can't get MIDI-in.  I havn't really tested with alsa compatible software (aseqview only) I need access to ramidi devices (well, for now).

Any ideas about such behaviour?
I'm on DebianPPC, 2.4.18, today's alsa's CVS.

thanks.
-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
