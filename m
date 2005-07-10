From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Disabling fake 3D sound with es1688
Date: Sun, 10 Jul 2005 22:25:55 +1000
Message-ID: <20050710222555.67b4a876.a.nielsen@shikadi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

Hi all,

I've got a laptop with an onboard es1688 based ISA sound card, and it
has an annoying 3D stereo effect I want to disable.  I've seen other
sound cards that have a mixer control that can disable this, but
apparently not the es1688.  I was just wondering whether anyone is aware
of any way of disabling it (there's no module option and the source
code doesn't indicate anything), or failing that if someone has the
datasheet for the chip, as it seems very difficult to find (I can only
find one explaining what the pins are for, not one detailing the
software interface to the chip.)

Any info would be greatly appreciated!

Thanks,
Adam.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
