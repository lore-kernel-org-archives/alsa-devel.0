From: thomas schorpp <t.schorpp@gmx.de>
Subject: [INFO] C-Media CMI9761 -A- type , CONTINOUS NOT DISCRETE MASTER/PCM
 MIXER with 106, please branch, PCM PLAY not working
Date: Wed, 16 Feb 2005 06:21:42 +0100
Message-ID: <4212D866.5000304@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

hello,

this device

http://www.cmedia.com.tw/product/CMI9761.htm

the -A- type ive got

has working continuous (slider) master mixer+balance and "working" pcm
mixer slider with v106 (2.6.10 release kernel alsa) but no more with
v108 alsa-driver or cvs from yesterday.

please branch for this device (on cheap asrock mass-seller K7VTA+ board
with via8235 pci).

- -worse: pcm playback not working, capture works, seems no muting
problem, klick sound on switching pcm mixer.

10 days left to fix it, or the board returns to the shop.

need a start point for pcm problem, please. somebody got a reg
descrption? only harware datasheet is available from vendor.

?

y
tom





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iQCVAwUBQhLYYmqsze5HSzyoAQPQGAP+NkGJTBonfz23+wKI/YHGjGqfratVRFPL
0/gaV3PCa+SGcW82QHfs/QPY0W0f4F013QUz+EQUQOxeLnNEvHOaqFbddL5zAIL3
2LTthgN+rGqfG7RZHfjOkOoU3tE0jjXU5UljqNO1A9Jd2tFGfQUJUZIn+B3RKCya
Buuk4eI11gQ=
=Q2Au
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
