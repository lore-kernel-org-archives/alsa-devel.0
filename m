From: iriXx <m@iriXx.org>
Subject: usb audio + mandrake 9.0 foobar :(
Date: Fri, 13 Dec 2002 20:38:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFA4539.7050207@iriXx.org>
Reply-To: m@iriXx.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi

just upgraded mandrake from 8.2 to 9.0....
and found out that it seems to have made my alsa all foobar.... :(

i recompiled and reinstalled alsa 0.9.rc5 after upgrading... but i dont
seem to be able to get it working.
im running a quattro usb audio unit... modprobe snd-usb-audio,
snd-pcm-oss, snd-mixer-oss, snd-seq-oss all goes fine... but on opening
any sound or DVD apps i get error messages that there is no sound
support / no sound device found....

anyone got any ideas what may have happened?... is there a problem with
the supplied kernel perhaps ? it appears to be 2.4.19-16mdk

thanx

m~

- --
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

~ _
( )  ascii ribbon against html email
~ X
/ \    cat /dev/sda1 > /dev/dsp


~  *** stopping make sense ***
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9+kU4GlmEEIa9/8YRAgZQAKChzE/GDsXnV2ibWGVeukLIhMuuXgCfaSS6
JhI8H299qo4awD86T56vJ5M=
=1Pwa
-----END PGP SIGNATURE-----



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
