From: Paul Winkler <pw_lists@slinkp.com>
Subject: Re: doc update
	for	http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Intel
Date: Sun, 23 Dec 2007 00:12:34 -0500
Message-ID: <20071223051234.GA5079@slinkp.com>
References: <20071217123708.A6661@slinkp.com> <s5hhcigxico.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ensim2.interlix.com (ensim2.interlix.com [64.22.224.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E7124350
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 06:12:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhcigxico.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 18, 2007 at 02:06:31PM +0100, Takashi Iwai wrote:
> At Mon, 17 Dec 2007 12:37:08 -0600,
> Paul Winkler wrote:
> > 
> > Hi,
> > 
> > The page at
> > http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Intel
> > makes it seem that cards identified as ICH7 must use the hda_intel
> > driver. This is apparently not always true.  I have a dell desktop
> > where snd_hda_intel refuses to load.  I fired up alsaconf and it
> > suggested using the intel8x0.  I tried that and it works fine.
> > 
> > So maybe ICH7 should be added to "chipsets" in the first row on that
> > page.
> 
> Right, up to ICH7 it supports both HD-audio and AC97.
> 
> Feel free to correct it.  It's a Wiki page ;)

I would have, but it was locked.
Someone has since unlocked it.  Edit done.

Thanks,

-- 

Paul Winkler
http://www.slinkp.com
