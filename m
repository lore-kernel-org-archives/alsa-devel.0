From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Can't record properly with cmi8738 card
Date: Tue, 09 Sep 2003 20:15:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xhe3lakwb.fsf@users.sourceforge.net>
References: <200308241501.58837.tobias__7241.2152695053$1063096402@rueckverdumung.de> <yw1x65k2bb0y.fsf@users.sourceforge.net>
 <bjl0gc$2mv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Tobias Deiminger <tobias.deiminger@ngi.de> writes:

> Maxtone Moving-Coil Mic Imp. 600 Ohm....  but i've got the same
> problem if I use my guitar instead of a mic. I tried also to use my
> v-amp as preamp for the guitar and this works a little better, but
> if I turn the preamp master too loud then the recorded signal gets
> distorted.

Most sound cards expect a cheap electret microphone.  These have much
higher output levels than coil-based ones.  I suggest you use a
pre-amp with output level suitable for the line-in input. Whatever the
usual hifi stuff uses for interconnection is appropriate.

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
