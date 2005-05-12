From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Dmix using more CPU than plug:hw
Date: Thu, 12 May 2005 22:24:20 +1000
Message-ID: <20050512222420.43363636.erikd-alsa@mega-nerd.com>
References: <20050507095346.37b16e6a.erikd-alsa@mega-nerd.com>
	<s5hmzr128wy.wl@alsa2.suse.de>
	<m2wtq5lv0q.fsf@vador.mandrakesoft.com>
	<s5hekcd26ky.wl@alsa2.suse.de>
	<20050512200848.1fe02c01.erikd-alsa@mega-nerd.com>
	<s5hmzr0zpuu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzr0zpuu.wl@alsa2.suse.de>
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

Takashi Iwai wrote:

> At Thu, 12 May 2005 20:08:48 +1000,
> Erik de Castro Lopo wrote:
>
> > Is this something that 1.0.9rc3 is likely to fix?
> 
> Might be...

Unfortunately not.

I installed alsa-driver-1.0.9rc3 and alsa-lib-1.0.9rc3. If I 
then run polypaudio it hangs, hard. So hard that I can't 
kill it. There's nothing in the system logs.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"The earth is degenerating these days. Bribery and corruption abound.
Children no longer mind parents ...and it is evident that the end of
the world is approaching fast." -- Assyrian Tablet Engraved in 2800 B.C.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
