From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Update: Additional info: Opening dev/dsp takes very
 long
Date: Sun, 14 Mar 2004 16:42:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40547D61.9050008@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- - I have tried to use a non preemptive kernel and as a suprise to me,
the problem is still there.

- - After googeling around, I found this post to [linux-audio-dev]:
http://eca.cx/lad/2003/11/0081.html.
What's strinking is, that he uses a 2496 card, too. Maybe this is
related to the ice1712 driver ?

Could someone tell me how to enabled debug output on the alsa-driver and
the OSS emulation, so I can try to track the problem ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAVH1hrp9JEomxNXERAsOzAKCAVLois3gaYmXBMY0k5l0rTYHG7gCcCUjs
8iB6DWOtgWN1DHHxrAloBuM=
=1/Lw
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
