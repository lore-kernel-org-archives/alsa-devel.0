From: Andrew Morton <akpm@osdl.org>
Subject: Fw: 2.6.12: codec_semaphore: semaphore is not ready
Date: Sun, 19 Jun 2005 17:31:31 -0700
Message-ID: <20050619173131.1fc8cf6b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: Rafael =?ISO-8859-1?B?Um9kcu1ndWV6?= <apt-drink@gulic.org>
List-Id: alsa-devel@alsa-project.org



Begin forwarded message:

Date: Sun, 19 Jun 2005 14:02:02 +0100
From: Rafael Rodr=EDguez <apt-drink@gulic.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12: codec_semaphore: semaphore is not ready


Hi. Since I upgraded to 2.6.12, i get messages like

codec_semaphore: semaphore is not ready [0x1][0x
301300]
codec_write 1: semaphoreis not ready for register 0x54

_randomly_ (meaning that in some boots it shows up, but in others doesn't) =
in=20
some init scripts (for example, alsa).

It's an HP pavilion zv5000 (amd64 laptop). Please tell me which more info m=
ay=20
I supply to trace this. But I repeat, it's not _always_ reproducible.

Regards,

Rafael Rodr=EDguez
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
