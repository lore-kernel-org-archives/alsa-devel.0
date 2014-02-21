From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [RFC v3] [PATCH 00/52] Enhancement for support of
	firewire devices
Date: Fri, 21 Feb 2014 21:28:04 +0100
Message-ID: <20140221212804.061e8b30@stein>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
	<20140221165444.GA25817@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20140221165444.GA25817@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Jay Fenlason <fenlason@redhat.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Feb 21 Jay Fenlason wrote:
> I could not play audio through the FireWave (either directly via aplay
> or through PulseAudio).  This is a regression from the fwspkr driver,
> which worked on this machine.

Did you apply this patch series, or pull from git?
(https://github.com/takaswie/snd-firewire-improve)
Griffin FireWave and Lacie Speakers need this here:
https://github.com/takaswie/snd-firewire-improve/commit/fae91361062fca5491ec54baddd6f009e57703f5
(Haven't arranged to pull and test myself yet.)
-- 
Stefan Richter
-=====-====- --=- =-=-=
http://arcgraph.de/sr/

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
