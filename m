From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: A need for support for SPI interfacing in alsa.
Date: Sat, 02 Oct 2004 15:02:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096743770.5845.27.camel@krustophenia.net>
References: <415EF5B2.6050106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id EA40E22D
	for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2004 21:02:52 +0200 (MEST)
In-Reply-To: <415EF5B2.6050106@superbug.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-10-02 at 14:38, James Courtier-Dutton wrote:
> More and more sound card manufacturers are moving away from AC97 codecs.
> Up until recently, this was not really a problem, but I came across a 
> new sound card today. The Creative SB Live! 7.1 24bit.
> This is based on the Audigy LS.

Wait, is this a PCI card?  Does it have the FX8010 DSP?  I really hope
this does not mean they are moving away from the emu10k1/emu10k2
architecture in order to support 24/96.  I was hoping they would come
out with an emu10k3 with a similar architecture to the emu10k1/10k2
except running at 96Khz.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
