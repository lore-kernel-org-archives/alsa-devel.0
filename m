From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Tue, 24 Feb 2004 17:26:31 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402241726.RAA31256@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402231010240.20713-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402231010240.20713-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> wrote:
>
>add aplaymidi & arecordmidi utilities
>

Having these command-line utilities is very useful.  Previously there
were only the old OSS command-line programs like (x)playmidi and drvmidi.

How easy would it be to make aplaymidi be able to adjust the playback speed
like playmidi?  (playmidi -t 0.5 music.mid plays at twice the default speed)

How easy would it be to make aplaymidi be able to move forwards and backwards
during playback, e.g. by pressing f or b, like Takashi Iwai's drvmidi?

William



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
