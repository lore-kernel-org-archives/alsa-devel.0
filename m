From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Mon, 2 Jun 2003 14:19:27 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306021416560.1091-100000@ecabase.localdomain>
References: <s5hd6hwpwrm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6hwpwrm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2 Jun 2003, Takashi Iwai wrote:

>> running jack :)), sometimes with both soundcards running at the same time, 
>> and still no oopses (system uptime now 5days). So ALSA+SMP seems to work 
> which card are you using?
> if it's the card with linked-stream feature (like trident, hdsp,
> ice1712, etc.), the bug was likely solved.  if not, we still need to
> investigate the behabior...

One Delta44/ice1712 and one ens1371.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
