From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: When I use xmms with OSS plugin sound is normal with the ALSA
 plugin sound skips sometimes
Date: Wed, 11 Feb 2004 22:11:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xr7x1wcc3.fsf@kth.se>
References: <1076521331.2782.5.camel@D5E03F95.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Kristof vansant <de_lupus@pandora.be> writes:

> When I use xmms with OSS plugin sound is normal but with the ALSA plugin
> sound skips sometimes.
>
> Is this a xmms problem? Or makes OSS emulation the sound stable?

It's an xmms problem.  Read the code and you'll see why.  It can skip
with OSS output too.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
