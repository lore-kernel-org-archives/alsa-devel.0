From: risc@volumehost.com
Subject: toshiba satelite l35-s2151
Date: Wed, 14 Feb 2007 10:48:39 -0600
Message-ID: <20070214164839.GH28449@volumehost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hey, remember me?
i'm the one with the toshiba that would only play out its speakers..
well, now thats changed. the most recent HG tree dosent play sound on my laptop.
now, instead of the large spam message, when loading snd-hda-intel i get:

Feb 14 12:45:09 faiserver kernel: hda_codec: Unknown model for ALC660VD/ALC861VD, trying auto-probe from BIOS...
Feb 14 12:45:09 faiserver kernel: ALSA /usr/src/hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245: si3054: cannot initialize. EXT MID = 0000

and thats it. more items appear in my mixer settings, however, nothing will produce sound.

just thought i'd let someone know, its gone from bad, to worse. :)

willing to debug/backstep/etc, but i'm working 100 hours a week, so i don't have much time to muck arround.


Julia Longtin <risc@volumehost.com>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
